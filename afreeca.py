import re

from streamlink.plugin import Plugin
from streamlink.plugin.api import http, validate
from streamlink.stream import RTMPStream, HLSStream

CHANNEL_INFO_URL = "http://live.afreeca.com:8057/api/get_broad_state_list.php"
KEEP_ALIVE_URL = "{server}/stream_keepalive.html"
STREAM_INFO_URLS = "http://resourcemanager.afreeca.tv:9090/broad_stream_assign.html"
HLS_KEY_URL = "http://live.afreecatv.com:8057/afreeca/player_live_api.php"

CHANNEL_RESULT_ERROR = 0
CHANNEL_RESULT_OK = 1

QUALITYS=["original", "hd", "sd"]

QUALITY_WEIGHTS = {
    "gs_original": 1080,
    "gs_hd": 720,
    "gs_sd": 480,
    "aws_original": 1081,
    "aws_hd": 721,
    "aws_sd": 481,
}

CDN_SITES = {
    "gs": "gs_cdn",
    "aws": "aws_cf"
}

_url_re = re.compile(r"http(s)?://(?P<cdn>\w+\.)?afreeca(tv)?.com/(?P<username>\w+)(/\d+)?")

_channel_schema = validate.Schema(
    {
        "CHANNEL": {
            "RESULT": validate.transform(int),
            "BROAD_INFOS": [{
                "list": [{
                    "nBroadNo": validate.text
                }]
            }]
        }
    },
    validate.get("CHANNEL")
)
_stream_schema = validate.Schema(
    {
        validate.optional("view_url"): validate.url(
            scheme=validate.any("rtmp", "http")
        )
    }
)

class AfreecaTV(Plugin):
    @classmethod
    def can_handle_url(self, url):
        return _url_re.match(url)

    @classmethod
    def stream_weight(cls, key):
        weight = QUALITY_WEIGHTS.get(key)
        if weight:
            return weight, "afreeca"

        return Plugin.stream_weight(key)

    def _get_channel_info(self, username):
        headers = {
            "Referer": self.url
        }
        params = {
            "uid": username
        }
        res = http.get(CHANNEL_INFO_URL, params=params, headers=headers)

        return http.json(res, schema=_channel_schema)

    def _get_hls_key(self, broadcast, username, quality):
        headers = {
            "Referer": self.url
        }

        data = {
            "bid": username,
            "bno": broadcast,
            "player_type": "html5",
            "pwd": "",
            "quality": quality,
            "type": "pwd"
        }
        res = http.post(HLS_KEY_URL, data=data, headers=headers)
        return http.json(res)

    def _get_stream_info(self, broadcast, quality, cdn):
        params={
            "return_type": cdn,
            "use_cors": "true",
            "cors_origin_url": "play.afreecatv.com",
            "broad_key": "{broadcast}-flash-{quality}-hls".format(**locals())
        }
        res = http.get(STREAM_INFO_URLS, params=params)
        return http.json(res, schema=_stream_schema)

    def _get_hls_stream(self, broadcast, username, quality, cdn):
        keyjson = self._get_hls_key(broadcast, username, quality)
        if keyjson["CHANNEL"]["RESULT"] != "1":
            return
        key = keyjson["CHANNEL"]["AID"]
        
        info = self._get_stream_info(broadcast, quality, cdn)
        if "view_url" in info:
            return HLSStream(self.session, info["view_url"], params=dict(aid=key))


    def _get_streams(self):
        match = _url_re.match(self.url)
        username = match.group("username")
        tcdn = match.group("cdn")
        if tcdn=="aws.":
            cdn="aws_cf"
        else:
            cdn="gs_cdn"

        channel = self._get_channel_info(username)
        if channel["RESULT"] != CHANNEL_RESULT_OK:
            return

        broadcast = channel["BROAD_INFOS"][0]["list"][0]["nBroadNo"]
        if not broadcast:
            return

        for skey in CDN_SITES:
            for qkey in QUALITYS:
                hls_stream = self._get_hls_stream(broadcast, username, qkey, CDN_SITES.get(skey))
                if hls_stream:
                    yield skey+"_"+qkey, hls_stream

__plugin__ = AfreecaTV
