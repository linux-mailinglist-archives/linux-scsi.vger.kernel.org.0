Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC81F525D
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2020 12:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgFJKdP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jun 2020 06:33:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:7666 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgFJKdM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 10 Jun 2020 06:33:12 -0400
IronPort-SDR: jk+AMu2eqKNZzjT6epeeNzp3dAPI5TORUm2DgoDfwubrfzDaV6UbWXZujyTSv6kfbxvsrPmKi2
 ZixdwSKvDU3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 03:33:07 -0700
IronPort-SDR: YzdMU2E2r02N1M3eLRxjiGIFq69k5isfBrYyCIFBVz/40oEc319ujefg4w41v08mQd+4pmkApc
 ae4C+cO0YV1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,495,1583222400"; 
   d="scan'208";a="380023929"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2020 03:33:06 -0700
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jun 2020 03:33:06 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 10 Jun 2020 13:33:04 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 10 Jun 2020 13:33:04 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Bean Huo <huobean@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] scsi: ufs: Add SPDX GPL-2.0 to replace GPL v2
 boilerplate
Thread-Topic: [PATCH v3 1/2] scsi: ufs: Add SPDX GPL-2.0 to replace GPL v2
 boilerplate
Thread-Index: AQHWO3S8UoN7m4BGoEOt/WDIdsv7Y6jMOuqggAUvaACAAEN70A==
Date:   Wed, 10 Jun 2020 10:33:04 +0000
Message-ID: <717ee9934557424ba8d3fe7dd04659f1@intel.com>
References: <20200605200520.20831-1-huobean@gmail.com>
         <20200605200520.20831-2-huobean@gmail.com>
         <b9f2970c5061433b8acc16a10885e5b4@intel.com>
 <4b12ed3a47f6bb444f58ad480d584f3cf4c47819.camel@gmail.com>
In-Reply-To: <4b12ed3a47f6bb444f58ad480d584f3cf4c47819.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DQo+IGJvaWxlcnBsYXRlDQo+IA0KPiBPbiBTYXQsIDIwMjAtMDYtMDYgYXQgMjM6MjAgKzAwMDAs
IFdpbmtsZXIsIFRvbWFzIHdyb3RlOg0KPiA+ID4NCj4gPiA+IEZyb206IEJlYW4gSHVvIDxiZWFu
aHVvQG1pY3Jvbi5jb20+DQo+ID4gPg0KPiA+ID4gQWRkIFNQRFggR1BMLTIuMCB0byBVRlMgZHJp
dmVyIGZpbGVzIHRoYXQgc3BlY2lmaWVkIHRoZSBHUEwgdmVyc2lvbg0KPiA+ID4gMiBsaWNlbnNl
LA0KPiA+ID4gcmVtb3ZlIHRoZSBmdWxsIGJvaWxlcnBsYXRlIHRleHQuDQo+ID4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gPg0KPiA+IExH
VE0uDQo+ID4gVGhhbmtzDQo+ID4gVG9tYXMNCj4gDQo+IEhpIFRvbWFzDQo+IA0KPiB3b3VsZCB5
b3UgcGxlYXNlIGFkZCB5b3VyIHZpZXdlZCBvciBhY2tlZCB0YWcgZm9yIHRoaXMgcGF0Y2g/DQo+
IHRoYW5rcywNCg0KUmV2aWV3ZWQtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmtsZXJAaW50
ZWwuY29tPg0KDQo+IEJlYW4NCj4gDQo+IA0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L3Njc2kvdWZzL3Vmcy5oICAgICAgICAgICB8IDI3ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ID4gIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLXBjaS5jICAgIHwgMjUgKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLXBsdGZybS5j
IHwgMjcgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9zY3NpL3Vm
cy91ZnNoY2QuYyAgICAgICAgfCAzMCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
PiAtLQ0KPiA+ID4gIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmggICAgICAgIHwgMjcgKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2kuaCAg
ICAgICAgfCAyNyArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICA2IGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTU3IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vmcy5oIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnMu
aCBpbmRleA0KPiA+ID4gYzcwODQ1ZDQxNDQ5Li43ZGY0YmRjODEzZDYgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmcy5oDQo+ID4gPiArKysgYi9kcml2ZXJzL3Njc2kvdWZz
L3Vmcy5oDQo+ID4gPiBAQCAtMSwzNiArMSwxMSBAQA0KPiA+ID4gKy8qIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBVbml2
ZXJzYWwgRmxhc2ggU3RvcmFnZSBIb3N0IGNvbnRyb2xsZXIgZHJpdmVyDQo+ID4gPiAtICoNCj4g
PiA+IC0gKiBUaGlzIGNvZGUgaXMgYmFzZWQgb24gZHJpdmVycy9zY3NpL3Vmcy91ZnMuaA0KPiA+
ID4gICAqIENvcHlyaWdodCAoQykgMjAxMS0yMDEzIFNhbXN1bmcgSW5kaWEgU29mdHdhcmUgT3Bl
cmF0aW9ucw0KPiA+ID4gICAqDQo+ID4gPiAgICogQXV0aG9yczoNCj4gPiA+ICAgKglTYW50b3No
IFlhcmFnYW5hdmkgPHNhbnRvc2guc3lAc2Ftc3VuZy5jb20+DQo+ID4gPiAgICoJVmluYXlhayBI
b2xpa2F0dGkgPGgudmluYXlha0BzYW1zdW5nLmNvbT4NCj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3INCj4gPiA+IC0gKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQ0KPiA+ID4gLSAqIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyDQo+ID4gPiAtICogb2YgdGhlIExpY2Vu
c2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+ID4gPiAtICogU2Vl
IHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3Rvcnkgb3IgdmlzaXQNCj4g
PiA+IC0gKiA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzL2dwbC0yLjAuaHRtbD4NCj4gPiA+
IC0gKg0KPiA+ID4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPiA+ID4gLSAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5U
WTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+ID4gPiAtICogTUVSQ0hB
TlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0K
PiA+ID4gLSAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+
ID4gPiAtICoNCj4gPiA+IC0gKiBUaGlzIHByb2dyYW0gaXMgcHJvdmlkZWQgIkFTIElTIiBhbmQg
IldJVEggQUxMIEZBVUxUUyIgYW5kDQo+ID4gPiAtICogd2l0aG91dCB3YXJyYW50eSBvZiBhbnkg
a2luZC4gWW91IGFyZSBzb2xlbHkgcmVzcG9uc2libGUgZm9yDQo+ID4gPiAtICogZGV0ZXJtaW5p
bmcgdGhlIGFwcHJvcHJpYXRlbmVzcyBvZiB1c2luZyBhbmQgZGlzdHJpYnV0aW5nDQo+ID4gPiAt
ICogdGhlIHByb2dyYW0gYW5kIGFzc3VtZSBhbGwgcmlza3MgYXNzb2NpYXRlZCB3aXRoIHlvdXIg
ZXhlcmNpc2UNCj4gPiA+IC0gKiBvZiByaWdodHMgd2l0aCByZXNwZWN0IHRvIHRoZSBwcm9ncmFt
LCBpbmNsdWRpbmcgYnV0IG5vdCBsaW1pdGVkDQo+ID4gPiAtICogdG8gaW5mcmluZ2VtZW50IG9m
IHRoaXJkIHBhcnR5IHJpZ2h0cywgdGhlIHJpc2tzIGFuZCBjb3N0cyBvZg0KPiA+ID4gLSAqIHBy
b2dyYW0gZXJyb3JzLCBkYW1hZ2UgdG8gb3IgbG9zcyBvZiBkYXRhLCBwcm9ncmFtcyBvcg0KPiA+
ID4gZXF1aXBtZW50LA0KPiA+ID4gLSAqIGFuZCB1bmF2YWlsYWJpbGl0eSBvciBpbnRlcnJ1cHRp
b24gb2Ygb3BlcmF0aW9ucy4gVW5kZXIgbm8NCj4gPiA+IC0gKiBjaXJjdW1zdGFuY2VzIHdpbGwg
dGhlIGNvbnRyaWJ1dG9yIG9mIHRoaXMgUHJvZ3JhbSBiZSBsaWFibGUgZm9yDQo+ID4gPiAtICog
YW55IGRhbWFnZXMgb2YgYW55IGtpbmQgYXJpc2luZyBmcm9tIHlvdXIgdXNlIG9yIGRpc3RyaWJ1
dGlvbiBvZg0KPiA+ID4gLSAqIHRoaXMgcHJvZ3JhbS4NCj4gPiA+ICAgKi8NCj4gPiA+DQo+ID4g
PiAgI2lmbmRlZiBfVUZTX0gNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC1wY2kuYw0KPiA+ID4gYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC1wY2kuYyBpbmRleCA4
Zjc4YTgxNTE0OTkuLmY0MDdiMTM4ODNhYw0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL3Njc2kvdWZzL3Vmc2hjZC1wY2kuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy91
ZnNoY2QtcGNpLmMNCj4gPiA+IEBAIC0xLDMgKzEsNCBAQA0KPiA+ID4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBVbml2
ZXJzYWwgRmxhc2ggU3RvcmFnZSBIb3N0IGNvbnRyb2xsZXIgUENJIGdsdWUgZHJpdmVyDQo+ID4g
PiAgICoNCj4gPiA+IEBAIC03LDMwICs4LDYgQEANCj4gPiA+ICAgKiBBdXRob3JzOg0KPiA+ID4g
ICAqCVNhbnRvc2ggWWFyYWdhbmF2aSA8c2FudG9zaC5zeUBzYW1zdW5nLmNvbT4NCj4gPiA+ICAg
KglWaW5heWFrIEhvbGlrYXR0aSA8aC52aW5heWFrQHNhbXN1bmcuY29tPg0KPiA+ID4gLSAqDQo+
ID4gPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vcg0KPiA+ID4gLSAqIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+ID4gPiAtICogYXMgcHVibGlzaGVkIGJ5IHRo
ZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDINCj4gPiA+IC0gKiBv
ZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4g
PiA+IC0gKiBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeSBv
ciB2aXNpdA0KPiA+ID4gLSAqIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvZ3BsLTIuMC5o
dG1sPg0KPiA+ID4gLSAqDQo+ID4gPiAtICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+ID4gPiAtICogYnV0IFdJVEhPVVQg
QU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4gPiA+
IC0gKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0Uu
ICBTZWUgdGhlDQo+ID4gPiAtICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4NCj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBwcm92aWRlZCAi
QVMgSVMiIGFuZCAiV0lUSCBBTEwgRkFVTFRTIiBhbmQNCj4gPiA+IC0gKiB3aXRob3V0IHdhcnJh
bnR5IG9mIGFueSBraW5kLiBZb3UgYXJlIHNvbGVseSByZXNwb25zaWJsZSBmb3INCj4gPiA+IC0g
KiBkZXRlcm1pbmluZyB0aGUgYXBwcm9wcmlhdGVuZXNzIG9mIHVzaW5nIGFuZCBkaXN0cmlidXRp
bmcNCj4gPiA+IC0gKiB0aGUgcHJvZ3JhbSBhbmQgYXNzdW1lIGFsbCByaXNrcyBhc3NvY2lhdGVk
IHdpdGggeW91ciBleGVyY2lzZQ0KPiA+ID4gLSAqIG9mIHJpZ2h0cyB3aXRoIHJlc3BlY3QgdG8g
dGhlIHByb2dyYW0sIGluY2x1ZGluZyBidXQgbm90IGxpbWl0ZWQNCj4gPiA+IC0gKiB0byBpbmZy
aW5nZW1lbnQgb2YgdGhpcmQgcGFydHkgcmlnaHRzLCB0aGUgcmlza3MgYW5kIGNvc3RzIG9mDQo+
ID4gPiAtICogcHJvZ3JhbSBlcnJvcnMsIGRhbWFnZSB0byBvciBsb3NzIG9mIGRhdGEsIHByb2dy
YW1zIG9yDQo+ID4gPiBlcXVpcG1lbnQsDQo+ID4gPiAtICogYW5kIHVuYXZhaWxhYmlsaXR5IG9y
IGludGVycnVwdGlvbiBvZiBvcGVyYXRpb25zLiBVbmRlciBubw0KPiA+ID4gLSAqIGNpcmN1bXN0
YW5jZXMgd2lsbCB0aGUgY29udHJpYnV0b3Igb2YgdGhpcyBQcm9ncmFtIGJlIGxpYWJsZSBmb3IN
Cj4gPiA+IC0gKiBhbnkgZGFtYWdlcyBvZiBhbnkga2luZCBhcmlzaW5nIGZyb20geW91ciB1c2Ug
b3IgZGlzdHJpYnV0aW9uIG9mDQo+ID4gPiAtICogdGhpcyBwcm9ncmFtLg0KPiA+ID4gICAqLw0K
PiA+ID4NCj4gPiA+ICAjaW5jbHVkZSAidWZzaGNkLmgiDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zY3NpL3Vmcy91ZnNoY2QtcGx0ZnJtLmMNCj4gPiA+IGIvZHJpdmVycy9zY3NpL3Vmcy91
ZnNoY2QtcGx0ZnJtLmMNCj4gPiA+IGluZGV4IDc2ZjliZTcxYzMxYi4uM2RiMGFmNjZjNzFjIDEw
MDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QtcGx0ZnJtLmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLXBsdGZybS5jDQo+ID4gPiBAQCAtMSwzNiAr
MSwxMSBAQA0KPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBVbml2ZXJzYWwgRmxhc2ggU3RvcmFnZSBIb3N0IGNv
bnRyb2xsZXIgUGxhdGZvcm0gYnVzIGJhc2VkIGdsdWUNCj4gPiA+IGRyaXZlcg0KPiA+ID4gLSAq
DQo+ID4gPiAtICogVGhpcyBjb2RlIGlzIGJhc2VkIG9uIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNk
LXBsdGZybS5jDQo+ID4gPiAgICogQ29weXJpZ2h0IChDKSAyMDExLTIwMTMgU2Ftc3VuZyBJbmRp
YSBTb2Z0d2FyZSBPcGVyYXRpb25zDQo+ID4gPiAgICoNCj4gPiA+ICAgKiBBdXRob3JzOg0KPiA+
ID4gICAqCVNhbnRvc2ggWWFyYWdhbmF2aSA8c2FudG9zaC5zeUBzYW1zdW5nLmNvbT4NCj4gPiA+
ICAgKglWaW5heWFrIEhvbGlrYXR0aSA8aC52aW5heWFrQHNhbXN1bmcuY29tPg0KPiA+ID4gLSAq
DQo+ID4gPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vcg0KPiA+ID4gLSAqIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+ID4gPiAtICogYXMgcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDINCj4gPiA+IC0g
KiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4N
Cj4gPiA+IC0gKiBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9y
eSBvciB2aXNpdA0KPiA+ID4gLSAqIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvZ3BsLTIu
MC5odG1sPg0KPiA+ID4gLSAqDQo+ID4gPiAtICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+ID4gPiAtICogYnV0IFdJVEhP
VVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4g
PiA+IC0gKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBP
U0UuICBTZWUgdGhlDQo+ID4gPiAtICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgZGV0YWlscy4NCj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBwcm92aWRl
ZCAiQVMgSVMiIGFuZCAiV0lUSCBBTEwgRkFVTFRTIiBhbmQNCj4gPiA+IC0gKiB3aXRob3V0IHdh
cnJhbnR5IG9mIGFueSBraW5kLiBZb3UgYXJlIHNvbGVseSByZXNwb25zaWJsZSBmb3INCj4gPiA+
IC0gKiBkZXRlcm1pbmluZyB0aGUgYXBwcm9wcmlhdGVuZXNzIG9mIHVzaW5nIGFuZCBkaXN0cmli
dXRpbmcNCj4gPiA+IC0gKiB0aGUgcHJvZ3JhbSBhbmQgYXNzdW1lIGFsbCByaXNrcyBhc3NvY2lh
dGVkIHdpdGggeW91ciBleGVyY2lzZQ0KPiA+ID4gLSAqIG9mIHJpZ2h0cyB3aXRoIHJlc3BlY3Qg
dG8gdGhlIHByb2dyYW0sIGluY2x1ZGluZyBidXQgbm90IGxpbWl0ZWQNCj4gPiA+IC0gKiB0byBp
bmZyaW5nZW1lbnQgb2YgdGhpcmQgcGFydHkgcmlnaHRzLCB0aGUgcmlza3MgYW5kIGNvc3RzIG9m
DQo+ID4gPiAtICogcHJvZ3JhbSBlcnJvcnMsIGRhbWFnZSB0byBvciBsb3NzIG9mIGRhdGEsIHBy
b2dyYW1zIG9yDQo+ID4gPiBlcXVpcG1lbnQsDQo+ID4gPiAtICogYW5kIHVuYXZhaWxhYmlsaXR5
IG9yIGludGVycnVwdGlvbiBvZiBvcGVyYXRpb25zLiBVbmRlciBubw0KPiA+ID4gLSAqIGNpcmN1
bXN0YW5jZXMgd2lsbCB0aGUgY29udHJpYnV0b3Igb2YgdGhpcyBQcm9ncmFtIGJlIGxpYWJsZSBm
b3INCj4gPiA+IC0gKiBhbnkgZGFtYWdlcyBvZiBhbnkga2luZCBhcmlzaW5nIGZyb20geW91ciB1
c2Ugb3IgZGlzdHJpYnV0aW9uIG9mDQo+ID4gPiAtICogdGhpcyBwcm9ncmFtLg0KPiA+ID4gICAq
Lw0KPiA+ID4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYyBiL2RyaXZlcnMvc2NzaS91
ZnMvdWZzaGNkLmMNCj4gPiA+IGluZGV4DQo+ID4gPiBhZDRmYzgyOWNiYjIuLmVjNGY1NTIxMTY0
OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gPiA+IEBAIC0xLDQwICsxLDEyIEBADQo+
ID4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gPiA+
ICAvKg0KPiA+ID4gICAqIFVuaXZlcnNhbCBGbGFzaCBTdG9yYWdlIEhvc3QgY29udHJvbGxlciBk
cml2ZXIgQ29yZQ0KPiA+ID4gLSAqDQo+ID4gPiAtICogVGhpcyBjb2RlIGlzIGJhc2VkIG9uIGRy
aXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gPiA+ICAgKiBDb3B5cmlnaHQgKEMpIDIwMTEtMjAx
MyBTYW1zdW5nIEluZGlhIFNvZnR3YXJlIE9wZXJhdGlvbnMNCj4gPiA+ICAgKiBDb3B5cmlnaHQg
KGMpIDIwMTMtMjAxNiwgVGhlIExpbnV4IEZvdW5kYXRpb24uIEFsbCByaWdodHMNCj4gPiA+IHJl
c2VydmVkLg0KPiA+ID4gICAqDQo+ID4gPiAgICogQXV0aG9yczoNCj4gPiA+ICAgKglTYW50b3No
IFlhcmFnYW5hdmkgPHNhbnRvc2guc3lAc2Ftc3VuZy5jb20+DQo+ID4gPiAgICoJVmluYXlhayBI
b2xpa2F0dGkgPGgudmluYXlha0BzYW1zdW5nLmNvbT4NCj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3INCj4gPiA+IC0gKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZQ0KPiA+ID4gLSAqIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyDQo+ID4gPiAtICogb2YgdGhlIExpY2Vu
c2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+ID4gPiAtICogU2Vl
IHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3Rvcnkgb3IgdmlzaXQNCj4g
PiA+IC0gKiA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzL2dwbC0yLjAuaHRtbD4NCj4gPiA+
IC0gKg0KPiA+ID4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPiA+ID4gLSAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5U
WTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+ID4gPiAtICogTUVSQ0hB
TlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0K
PiA+ID4gLSAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+
ID4gPiAtICoNCj4gPiA+IC0gKiBUaGlzIHByb2dyYW0gaXMgcHJvdmlkZWQgIkFTIElTIiBhbmQg
IldJVEggQUxMIEZBVUxUUyIgYW5kDQo+ID4gPiAtICogd2l0aG91dCB3YXJyYW50eSBvZiBhbnkg
a2luZC4gWW91IGFyZSBzb2xlbHkgcmVzcG9uc2libGUgZm9yDQo+ID4gPiAtICogZGV0ZXJtaW5p
bmcgdGhlIGFwcHJvcHJpYXRlbmVzcyBvZiB1c2luZyBhbmQgZGlzdHJpYnV0aW5nDQo+ID4gPiAt
ICogdGhlIHByb2dyYW0gYW5kIGFzc3VtZSBhbGwgcmlza3MgYXNzb2NpYXRlZCB3aXRoIHlvdXIg
ZXhlcmNpc2UNCj4gPiA+IC0gKiBvZiByaWdodHMgd2l0aCByZXNwZWN0IHRvIHRoZSBwcm9ncmFt
LCBpbmNsdWRpbmcgYnV0IG5vdCBsaW1pdGVkDQo+ID4gPiAtICogdG8gaW5mcmluZ2VtZW50IG9m
IHRoaXJkIHBhcnR5IHJpZ2h0cywgdGhlIHJpc2tzIGFuZCBjb3N0cyBvZg0KPiA+ID4gLSAqIHBy
b2dyYW0gZXJyb3JzLCBkYW1hZ2UgdG8gb3IgbG9zcyBvZiBkYXRhLCBwcm9ncmFtcyBvcg0KPiA+
ID4gZXF1aXBtZW50LA0KPiA+ID4gLSAqIGFuZCB1bmF2YWlsYWJpbGl0eSBvciBpbnRlcnJ1cHRp
b24gb2Ygb3BlcmF0aW9ucy4gVW5kZXIgbm8NCj4gPiA+IC0gKiBjaXJjdW1zdGFuY2VzIHdpbGwg
dGhlIGNvbnRyaWJ1dG9yIG9mIHRoaXMgUHJvZ3JhbSBiZSBsaWFibGUgZm9yDQo+ID4gPiAtICog
YW55IGRhbWFnZXMgb2YgYW55IGtpbmQgYXJpc2luZyBmcm9tIHlvdXIgdXNlIG9yIGRpc3RyaWJ1
dGlvbiBvZg0KPiA+ID4gLSAqIHRoaXMgcHJvZ3JhbS4NCj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRo
ZSBMaW51eCBGb3VuZGF0aW9uIGNob29zZXMgdG8gdGFrZSBzdWJqZWN0IG9ubHkgdG8gdGhlIEdQ
THYyDQo+ID4gPiAtICogbGljZW5zZSB0ZXJtcywgYW5kIGRpc3RyaWJ1dGVzIG9ubHkgdW5kZXIg
dGhlc2UgdGVybXMuDQo+ID4gPiAgICovDQo+ID4gPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9h
c3luYy5oPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmggYi9k
cml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQo+ID4gPiBpbmRleA0KPiA+ID4gYmY5N2Q2MTZlNTk3
Li5lZjkyYzRhOWUzNzggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hj
ZC5oDQo+ID4gPiArKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oDQo+ID4gPiBAQCAtMSwz
NyArMSwxMiBAQA0KPiA+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyICovDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBVbml2ZXJzYWwgRmxhc2ggU3RvcmFnZSBI
b3N0IGNvbnRyb2xsZXIgZHJpdmVyDQo+ID4gPiAtICoNCj4gPiA+IC0gKiBUaGlzIGNvZGUgaXMg
YmFzZWQgb24gZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuaA0KPiA+ID4gICAqIENvcHlyaWdodCAo
QykgMjAxMS0yMDEzIFNhbXN1bmcgSW5kaWEgU29mdHdhcmUgT3BlcmF0aW9ucw0KPiA+ID4gICAq
IENvcHlyaWdodCAoYykgMjAxMy0yMDE2LCBUaGUgTGludXggRm91bmRhdGlvbi4gQWxsIHJpZ2h0
cw0KPiA+ID4gcmVzZXJ2ZWQuDQo+ID4gPiAgICoNCj4gPiA+ICAgKiBBdXRob3JzOg0KPiA+ID4g
ICAqCVNhbnRvc2ggWWFyYWdhbmF2aSA8c2FudG9zaC5zeUBzYW1zdW5nLmNvbT4NCj4gPiA+ICAg
KglWaW5heWFrIEhvbGlrYXR0aSA8aC52aW5heWFrQHNhbXN1bmcuY29tPg0KPiA+ID4gLSAqDQo+
ID4gPiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vcg0KPiA+ID4gLSAqIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+ID4gPiAtICogYXMgcHVibGlzaGVkIGJ5IHRo
ZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDINCj4gPiA+IC0gKiBv
ZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCj4g
PiA+IC0gKiBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeSBv
ciB2aXNpdA0KPiA+ID4gLSAqIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvZ3BsLTIuMC5o
dG1sPg0KPiA+ID4gLSAqDQo+ID4gPiAtICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+ID4gPiAtICogYnV0IFdJVEhPVVQg
QU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4gPiA+
IC0gKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0Uu
ICBTZWUgdGhlDQo+ID4gPiAtICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4NCj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBwcm92aWRlZCAi
QVMgSVMiIGFuZCAiV0lUSCBBTEwgRkFVTFRTIiBhbmQNCj4gPiA+IC0gKiB3aXRob3V0IHdhcnJh
bnR5IG9mIGFueSBraW5kLiBZb3UgYXJlIHNvbGVseSByZXNwb25zaWJsZSBmb3INCj4gPiA+IC0g
KiBkZXRlcm1pbmluZyB0aGUgYXBwcm9wcmlhdGVuZXNzIG9mIHVzaW5nIGFuZCBkaXN0cmlidXRp
bmcNCj4gPiA+IC0gKiB0aGUgcHJvZ3JhbSBhbmQgYXNzdW1lIGFsbCByaXNrcyBhc3NvY2lhdGVk
IHdpdGggeW91ciBleGVyY2lzZQ0KPiA+ID4gLSAqIG9mIHJpZ2h0cyB3aXRoIHJlc3BlY3QgdG8g
dGhlIHByb2dyYW0sIGluY2x1ZGluZyBidXQgbm90IGxpbWl0ZWQNCj4gPiA+IC0gKiB0byBpbmZy
aW5nZW1lbnQgb2YgdGhpcmQgcGFydHkgcmlnaHRzLCB0aGUgcmlza3MgYW5kIGNvc3RzIG9mDQo+
ID4gPiAtICogcHJvZ3JhbSBlcnJvcnMsIGRhbWFnZSB0byBvciBsb3NzIG9mIGRhdGEsIHByb2dy
YW1zIG9yDQo+ID4gPiBlcXVpcG1lbnQsDQo+ID4gPiAtICogYW5kIHVuYXZhaWxhYmlsaXR5IG9y
IGludGVycnVwdGlvbiBvZiBvcGVyYXRpb25zLiBVbmRlciBubw0KPiA+ID4gLSAqIGNpcmN1bXN0
YW5jZXMgd2lsbCB0aGUgY29udHJpYnV0b3Igb2YgdGhpcyBQcm9ncmFtIGJlIGxpYWJsZSBmb3IN
Cj4gPiA+IC0gKiBhbnkgZGFtYWdlcyBvZiBhbnkga2luZCBhcmlzaW5nIGZyb20geW91ciB1c2Ug
b3IgZGlzdHJpYnV0aW9uIG9mDQo+ID4gPiAtICogdGhpcyBwcm9ncmFtLg0KPiA+ID4gICAqLw0K
PiA+ID4NCj4gPiA+ICAjaWZuZGVmIF9VRlNIQ0RfSA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc2NzaS91ZnMvdWZzaGNpLmggYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjaS5oDQo+ID4gPiBp
bmRleA0KPiA+ID4gYzI5NjFkMzdjYzFjLi4yYzFjN2EyNzc0MzAgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjaS5oDQo+ID4gPiArKysgYi9kcml2ZXJzL3Njc2kvdWZz
L3Vmc2hjaS5oDQo+ID4gPiBAQCAtMSwzNiArMSwxMSBAQA0KPiA+ID4gKy8qIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovDQo+ID4gPiAgLyoNCj4gPiA+ICAgKiBV
bml2ZXJzYWwgRmxhc2ggU3RvcmFnZSBIb3N0IGNvbnRyb2xsZXIgZHJpdmVyDQo+ID4gPiAtICoN
Cj4gPiA+IC0gKiBUaGlzIGNvZGUgaXMgYmFzZWQgb24gZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2ku
aA0KPiA+ID4gICAqIENvcHlyaWdodCAoQykgMjAxMS0yMDEzIFNhbXN1bmcgSW5kaWEgU29mdHdh
cmUgT3BlcmF0aW9ucw0KPiA+ID4gICAqDQo+ID4gPiAgICogQXV0aG9yczoNCj4gPiA+ICAgKglT
YW50b3NoIFlhcmFnYW5hdmkgPHNhbnRvc2guc3lAc2Ftc3VuZy5jb20+DQo+ID4gPiAgICoJVmlu
YXlhayBIb2xpa2F0dGkgPGgudmluYXlha0BzYW1zdW5nLmNvbT4NCj4gPiA+IC0gKg0KPiA+ID4g
LSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3INCj4gPiA+IC0gKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQ0KPiA+ID4gLSAqIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyDQo+ID4gPiAtICogb2YgdGhl
IExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uDQo+ID4gPiAt
ICogU2VlIHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3Rvcnkgb3Igdmlz
aXQNCj4gPiA+IC0gKiA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzL2dwbC0yLjAuaHRtbD4N
Cj4gPiA+IC0gKg0KPiA+ID4gLSAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPiA+ID4gLSAqIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+ID4gPiAtICog
TUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2Vl
IHRoZQ0KPiA+ID4gLSAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFp
bHMuDQo+ID4gPiAtICoNCj4gPiA+IC0gKiBUaGlzIHByb2dyYW0gaXMgcHJvdmlkZWQgIkFTIElT
IiBhbmQgIldJVEggQUxMIEZBVUxUUyIgYW5kDQo+ID4gPiAtICogd2l0aG91dCB3YXJyYW50eSBv
ZiBhbnkga2luZC4gWW91IGFyZSBzb2xlbHkgcmVzcG9uc2libGUgZm9yDQo+ID4gPiAtICogZGV0
ZXJtaW5pbmcgdGhlIGFwcHJvcHJpYXRlbmVzcyBvZiB1c2luZyBhbmQgZGlzdHJpYnV0aW5nDQo+
ID4gPiAtICogdGhlIHByb2dyYW0gYW5kIGFzc3VtZSBhbGwgcmlza3MgYXNzb2NpYXRlZCB3aXRo
IHlvdXIgZXhlcmNpc2UNCj4gPiA+IC0gKiBvZiByaWdodHMgd2l0aCByZXNwZWN0IHRvIHRoZSBw
cm9ncmFtLCBpbmNsdWRpbmcgYnV0IG5vdCBsaW1pdGVkDQo+ID4gPiAtICogdG8gaW5mcmluZ2Vt
ZW50IG9mIHRoaXJkIHBhcnR5IHJpZ2h0cywgdGhlIHJpc2tzIGFuZCBjb3N0cyBvZg0KPiA+ID4g
LSAqIHByb2dyYW0gZXJyb3JzLCBkYW1hZ2UgdG8gb3IgbG9zcyBvZiBkYXRhLCBwcm9ncmFtcyBv
cg0KPiA+ID4gZXF1aXBtZW50LA0KPiA+ID4gLSAqIGFuZCB1bmF2YWlsYWJpbGl0eSBvciBpbnRl
cnJ1cHRpb24gb2Ygb3BlcmF0aW9ucy4gVW5kZXIgbm8NCj4gPiA+IC0gKiBjaXJjdW1zdGFuY2Vz
IHdpbGwgdGhlIGNvbnRyaWJ1dG9yIG9mIHRoaXMgUHJvZ3JhbSBiZSBsaWFibGUgZm9yDQo+ID4g
PiAtICogYW55IGRhbWFnZXMgb2YgYW55IGtpbmQgYXJpc2luZyBmcm9tIHlvdXIgdXNlIG9yIGRp
c3RyaWJ1dGlvbiBvZg0KPiA+ID4gLSAqIHRoaXMgcHJvZ3JhbS4NCj4gPiA+ICAgKi8NCj4gPiA+
DQo+ID4gPiAgI2lmbmRlZiBfVUZTSENJX0gNCj4gPiA+IC0tDQo+ID4gPiAyLjE3LjENCj4gPg0K
PiA+DQoNCg==
