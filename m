Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF17CE09D
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Oct 2023 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjJRPBS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Oct 2023 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRPBQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Oct 2023 11:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8677494
        for <linux-scsi@vger.kernel.org>; Wed, 18 Oct 2023 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697641229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQghU8JuOE2lS65npLT9gj1YqhpaX1k4189TtDxjVn8=;
        b=QIFDyGGZ+tX24aY5q6rPRdJ0aZsoR85po6BnpujcUUHbbfIPQ9N1n/gSRr3u5/eKybl4dr
        pZhKfBC5MjP7HdF1LP2fXjK5iGVubbK2N+Mk+tre38Rb+AmBDD1bOFoTR7PEWSmX0oKOSq
        SWKODdgh8xZSk+saI3crdadLgUQrVhI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-Vp9YBm0vP7ujmplWtlwFgw-1; Wed, 18 Oct 2023 11:00:27 -0400
X-MC-Unique: Vp9YBm0vP7ujmplWtlwFgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F1662808CC1;
        Wed, 18 Oct 2023 15:00:07 +0000 (UTC)
Received: from [10.22.18.63] (unknown [10.22.18.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7999C15BB8;
        Wed, 18 Oct 2023 15:00:06 +0000 (UTC)
Message-ID: <835aeb57-535a-6c4f-dcb5-ec47915637af@redhat.com>
Date:   Wed, 18 Oct 2023 11:00:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] bnx2fc: Remove dma_alloc_coherent to suppress the
 BUG_ON.
Content-Language: en-US
To:     Saurav Kashyap <skashyap@marvell.com>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20230824061838.13103-1-skashyap@marvell.com>
From:   John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20230824061838.13103-1-skashyap@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

TWFydGluLCBSZWQgSGF0IHdvdWxkIGxpa2UgdG8gZ2V0IHRoaXMgbWVyZ2VkLg0KDQpDYW4g
d2UgZG8gdGhhdCwgb3IgYXJlIHRoZXJlIG90aGVyIGlzc3VlcyB0aGF0IG5lZWQgdG8gYmUg
YWRkcmVzc2VkIHdpdGggdGhpcyBwYXRjaD8NCg0KUmV2aWV3ZWQtYnk6IEpvaG4gTWVuZWdo
aW5pIDxqbWVuZWdoaUByZWRoYXQuY29tPg0KDQpPbiA4LzI0LzIzIDAyOjE4LCBTYXVyYXYg
S2FzaHlhcCB3cm90ZToNCj4gRnJvbTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVk
aGF0LmNvbT4NCj4gDQo+IGRtYV9mcmVlX2NvaGVyZW50IHNob3VsZCBub3QgYmUgY2FsbGVk
IHVuZGVyIHNwaW5fbG9ja19iaCwNCj4gdGhpcyBwYXRjaCBjaGFuZ2VkIGRtYSBjb2hlcmVu
dCBjYWxscyB0byBremFsbG9jIGFuZCBkbWFfbWFwX3NpbmdsZS4NCj4gDQo+IFsgIDQ0OS44
NDMxNDNdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBbICA0NDku
ODQ4MzAyXSBrZXJuZWwgQlVHIGF0IG1tL3ZtYWxsb2MuYzoyNzI3IQ0KPiBbICA0NDkuODUz
MDcyXSBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFBSRUVNUFQgU01QIFBUSQ0KPiBbICA0
NDkuODU4NzEyXSBDUFU6IDUgUElEOiAxOTk2IENvbW06IGt3b3JrZXIvdTI0OjIgTm90IHRh
aW50ZWQgNS4xNC4wLTExOC5lbDkueDg2XzY0ICMxDQo+IFJlYm9vdGluZy4NCj4gWyAgNDQ5
Ljg2NzQ1NF0gSGFyZHdhcmUgbmFtZTogRGVsbCBJbmMuIFBvd2VyRWRnZSBSNzMwLzBXQ0pO
VCwgQklPUyAyLjMuNCAxMS8wOC8yMDE2DQo+IFsgIDQ0OS44NzY5NjZdIFdvcmtxdWV1ZTog
ZmNfcnBvcnRfZXEgZmNfcnBvcnRfd29yayBbbGliZmNdDQo+IFsgIDQ0OS44ODI5MTBdIFJJ
UDogMDAxMDp2dW5tYXArMHgyZS8weDMwDQo+IFsgIDQ0OS44ODcwOThdIENvZGU6IDAwIDY1
IDhiIDA1IDE0IGEyIGYwIDRhIGE5IDAwIGZmIGZmIDAwIDc1IDFiIDU1IDQ4IDg5IGZkIGU4
IDM0IDM2IDc5IDAwIDQ4IDg1IGVkIDc0IDBiIDQ4IDg5IGVmIDMxIGY2IDVkIGU5IDE0IGZj
IGZmIGZmIDVkIGMzIDwwZj4gMGIgMGYgMWYgNDQgMDAgMDAgNDEgNTcgNDEgNTYgNDkgODkg
Y2UgNDEgNTUgNDkgODkgZmQgNDEgNTQgNDENCj4gWyAgNDQ5LjkwODA1NF0gUlNQOiAwMDE4
OmZmZmZiODNkODc4YjNkNjggRUZMQUdTOiAwMDAxMDIwNg0KPiBbICA0NDkuOTEzODg3XSBS
QVg6IDAwMDAwMDAwODAwMDAyMDEgUkJYOiBmZmZmOGY0MzU1MTMzNTUwIFJDWDogMDAwMDAw
MDAwZDQwMDAwNQ0KPiBbICA0NDkuOTIxODQzXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDEgUlNJ
OiAwMDAwMDAwMDAwMDAxMDAwIFJESTogZmZmZmI4M2RhNTNmNTAwMA0KPiBbICA0NDkuOTI5
ODA4XSBSQlA6IGZmZmY4ZjRhYzY2NzU4MDAgUjA4OiBmZmZmYjgzZDg3OGIzZDMwIFIwOTog
MDAwMDAwMDAwMDBlZmJkZg0KPiBbICA0NDkuOTM3Nzc0XSBSMTA6IDAwMDAwMDAwMDAwMDAw
MDMgUjExOiBmZmZmOGY0MzQ1NzNlMDAwIFIxMjogMDAwMDAwMDAwMDAwMTAwMA0KPiBbICA0
NDkuOTQ1NzM2XSBSMTM6IDAwMDAwMDAwMDAwMDEwMDAgUjE0OiBmZmZmYjgzZGE1M2Y1MDAw
IFIxNTogZmZmZjhmNDNkNGVhM2FlMA0KPiBbICA0NDkuOTUzNzAxXSBGUzogIDAwMDAwMDAw
MDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjhmNTI5ZmM4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwDQo+IFsgIDQ0OS45NjI3MzJdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAw
MCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gWyAgNDQ5Ljk2OTEzOF0gQ1IyOiAwMDAwN2Y4
Y2Y5OTNlMTUwIENSMzogMDAwMDAwMGVmYmUxMDAwMyBDUjQ6IDAwMDAwMDAwMDAzNzA2ZTAN
Cj4gWyAgNDQ5Ljk3NzEwMl0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAw
MDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgNDQ5Ljk4NTA2NV0gRFIzOiAw
MDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAw
MDA0MDANCj4gWyAgNDQ5Ljk5MzAyOF0gQ2FsbCBUcmFjZToNCj4gWyAgNDQ5Ljk5NTc1Nl0g
IF9faW9tbXVfZG1hX2ZyZWUrMHg5Ni8weDEwMA0KPiBbICA0NTAuMDAwMTM5XSAgYm54MmZj
X2ZyZWVfc2Vzc2lvbl9yZXNjKzB4NjcvMHgyNDAgW2JueDJmY10NCj4gWyAgNDUwLjAwNjE3
MV0gIGJueDJmY191cGxvYWRfc2Vzc2lvbisweGNlLzB4MTAwIFtibngyZmNdDQo+IFsgIDQ1
MC4wMTE5MTBdICBibngyZmNfcnBvcnRfZXZlbnRfaGFuZGxlcisweDlmLzB4MjQwIFtibngy
ZmNdDQo+IFsgIDQ1MC4wMTgxMzZdICBmY19ycG9ydF93b3JrKzB4MTAzLzB4NWIwIFtsaWJm
Y10NCj4gWyAgNDUwLjAyMzEwM10gIHByb2Nlc3Nfb25lX3dvcmsrMHgxZTgvMHgzYzANCj4g
WyAgNDUwLjAyNzU4MV0gIHdvcmtlcl90aHJlYWQrMHg1MC8weDNiMA0KPiBbICA0NTAuMDMx
NjY5XSAgPyByZXNjdWVyX3RocmVhZCsweDM3MC8weDM3MA0KPiBbICA0NTAuMDM2MTQzXSAg
a3RocmVhZCsweDE0OS8weDE3MA0KPiBbICA0NTAuMDM5NzQ0XSAgPyBzZXRfa3RocmVhZF9z
dHJ1Y3QrMHg0MC8weDQwDQo+IFsgIDQ1MC4wNDQ0MTFdICByZXRfZnJvbV9mb3JrKzB4MjIv
MHgzMA0KPiBbICA0NTAuMDQ4NDA0XSBNb2R1bGVzIGxpbmtlZCBpbjogdmZhdCBtc2RvcyBm
YXQgeGZzIG5mc19sYXlvdXRfbmZzdjQxX2ZpbGVzIHJwY3NlY19nc3Nfa3JiNSBhdXRoX3Jw
Y2dzcyBuZnN2NCBkbnNfcmVzb2x2ZXIgZG1fc2VydmljZV90aW1lIHFlZGYgcWVkIGNyYzgg
Ym54MmZjIGxpYmZjb2UgbGliZmMgc2NzaV90cmFuc3BvcnRfZmMgaW50ZWxfcmFwbF9tc3Ig
aW50ZWxfcmFwbF9jb21tb24geDg2X3BrZ190ZW1wX3RoZXJtYWwgaW50ZWxfcG93ZXJjbGFt
cCBkY2RiYXMgcmFwbCBpbnRlbF9jc3RhdGUgaW50ZWxfdW5jb3JlIG1laV9tZSBwY3Nwa3Ig
bWVpIGlwbWlfc3NpZiBscGNfaWNoIGlwbWlfc2kgZnVzZSB6cmFtIGV4dDQgbWJjYWNoZSBq
YmQyIGxvb3AgbmZzdjMgbmZzX2FjbCBuZnMgbG9ja2QgZ3JhY2UgZnNjYWNoZSBuZXRmcyBp
cmRtYSBpY2Ugc2RfbW9kIHQxMF9waSBzZyBpYl91dmVyYnMgaWJfY29yZSA4MDIxcSBnYXJw
IG1ycCBzdHAgbGxjIG1nYWcyMDAgaTJjX2FsZ29fYml0IGRybV9rbXNfaGVscGVyIHN5c2Nv
cHlhcmVhIHN5c2ZpbGxyZWN0IHN5c2ltZ2JsdCBteG1fd21pIGZiX3N5c19mb3BzIGNlYyBj
cmN0MTBkaWZfcGNsbXVsIGFoY2kgY3JjMzJfcGNsbXVsIGJueDJ4IGRybSBnaGFzaF9jbG11
bG5pX2ludGVsIGxpYmFoY2kgcmZraWxsIGk0MGUgbGliYXRhIG1lZ2FyYWlkX3NhcyBtZGlv
IHdtaSBzdW5ycGMgbHJ3IGRtX2NyeXB0IGRtX3JvdW5kX3JvYmluIGRtX211bHRpcGF0aCBk
bV9zbmFwc2hvdCBkbV9idWZpbyBkbV9taXJyb3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9nIGRt
X3plcm8gZG1fbW9kIGxpbmVhciByYWlkMTAgcmFpZDQ1NiBhc3luY19yYWlkNl9yZWNvdiBh
c3luY19tZW1jcHkgYXN5bmNfcHEgYXN5bmNfeG9yIGFzeW5jX3R4IHJhaWQ2X3BxIGxpYmNy
YzMyYyBjcmMzMmNfaW50ZWwgcmFpZDEgcmFpZDAgaXNjc2lfaWJmdCBzcXVhc2hmcyBiZTJp
c2NzaSBibngyaSBjbmljIHVpbyBjeGdiNGkgY3hnYjQgdGxzDQo+IFsgIDQ1MC4wNDg0OTdd
ICBsaWJjeGdiaSBsaWJjeGdiIHFsYTR4eHggaXNjc2lfYm9vdF9zeXNmcyBpc2NzaV90Y3Ag
bGliaXNjc2lfdGNwIGxpYmlzY3NpIHNjc2lfdHJhbnNwb3J0X2lzY3NpIGVkZCBpcG1pX2Rl
dmludGYgaXBtaV9tc2doYW5kbGVyDQo+IFsgIDQ1MC4xNTk3NTNdIC0tLVsgZW5kIHRyYWNl
IDcxMmRlMmM1N2M2NGFiYzggXS0tLQ0KPiANCj4gUmVwb3J0ZWQtYnk6IEd1YW5nd3UgWmhh
bmcgPGd1YXpoYW5nQHJlZGhhdC5jb20+DQo+IFRlc3RlZC1ieTogUmF2aSBBZGFiYWxhIDxy
YWRhYmFsYUBtYXJ2ZWxsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmVycnkgU25pdHNlbGFh
ciA8anNuaXRzZWxAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2F1cmF2IEthc2h5
YXAgPHNrYXNoeWFwQG1hcnZlbGwuY29tPg0KPiAtLS0NCj4gdjEgLT4gdjINCj4gLSBBZGRl
ZCBwYXRjaCBkZXNjcmlwdGlvbg0KPiAtIENvcnJlY3RlZCBKZXJyeSdzIG5hbWUNCj4gDQo+
ICAgZHJpdmVycy9zY3NpL2JueDJmYy9ibngyZmNfdGd0LmMgfCAyMjggKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNjYgaW5zZXJ0aW9u
cygrKSwgNjIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L2JueDJmYy9ibngyZmNfdGd0LmMgYi9kcml2ZXJzL3Njc2kvYm54MmZjL2JueDJmY190Z3Qu
Yw0KPiBpbmRleCAyYzI0NmU4MGMxYzQuLjAzNjI4Zjc3NjBlNyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9zY3NpL2JueDJmYy9ibngyZmNfdGd0LmMNCj4gKysrIGIvZHJpdmVycy9zY3Np
L2JueDJmYy9ibngyZmNfdGd0LmMNCj4gQEAgLTY3MSwxMiArNjcxLDE4IEBAIHN0YXRpYyBp
bnQgYm54MmZjX2FsbG9jX3Nlc3Npb25fcmVzYyhzdHJ1Y3QgYm54MmZjX2hiYSAqaGJhLA0K
PiAgIAl0Z3QtPnNxX21lbV9zaXplID0gKHRndC0+c3FfbWVtX3NpemUgKyAoQ05JQ19QQUdF
X1NJWkUgLSAxKSkgJg0KPiAgIAkJCSAgIENOSUNfUEFHRV9NQVNLOw0KPiAgIA0KPiAtCXRn
dC0+c3EgPSBkbWFfYWxsb2NfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+c3Ff
bWVtX3NpemUsDQo+IC0JCQkJICAgICAmdGd0LT5zcV9kbWEsIEdGUF9LRVJORUwpOw0KPiAr
CXRndC0+c3EgPSBremFsbG9jKHRndC0+c3FfbWVtX3NpemUsIEdGUF9LRVJORUwpOw0KPiAg
IAlpZiAoIXRndC0+c3EpIHsNCj4gICAJCXByaW50ayhLRVJOX0VSUiBQRlggInVuYWJsZSB0
byBhbGxvY2F0ZSBTUSBtZW1vcnkgJWRcbiIsDQo+ICAgCQkJdGd0LT5zcV9tZW1fc2l6ZSk7
DQo+IC0JCWdvdG8gbWVtX2FsbG9jX2ZhaWx1cmU7DQo+ICsJCWdvdG8gc3FfYWxsb2NfZmFp
bHVyZTsNCj4gKwl9DQo+ICsNCj4gKwl0Z3QtPnNxX2RtYSA9IGRtYV9tYXBfc2luZ2xlKCZo
YmEtPnBjaWRldi0+ZGV2LCB0Z3QtPnNxLA0KPiArCQkJCSAgICAgdGd0LT5zcV9tZW1fc2l6
ZSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArCWlmICh1bmxpa2VseShkbWFfbWFwcGluZ19l
cnJvcigmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5zcV9kbWEpKSkgew0KPiArCQlwcl9lcnIo
UEZYICJ1bmFibGUgdG8gbWFwIFNRIG1lbW9yeSAlZFxuIiwgdGd0LT5zcV9tZW1fc2l6ZSk7
DQo+ICsJCWdvdG8gc3FfbWFwX2ZhaWx1cmU7DQo+ICAgCX0NCj4gICANCj4gICAJLyogQWxs
b2NhdGUgYW5kIG1hcCBDUSAqLw0KPiBAQCAtNjg0LDEyICs2OTAsMTggQEAgc3RhdGljIGlu
dCBibngyZmNfYWxsb2Nfc2Vzc2lvbl9yZXNjKHN0cnVjdCBibngyZmNfaGJhICpoYmEsDQo+
ICAgCXRndC0+Y3FfbWVtX3NpemUgPSAodGd0LT5jcV9tZW1fc2l6ZSArIChDTklDX1BBR0Vf
U0laRSAtIDEpKSAmDQo+ICAgCQkJICAgQ05JQ19QQUdFX01BU0s7DQo+ICAgDQo+IC0JdGd0
LT5jcSA9IGRtYV9hbGxvY19jb2hlcmVudCgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5jcV9t
ZW1fc2l6ZSwNCj4gLQkJCQkgICAgICZ0Z3QtPmNxX2RtYSwgR0ZQX0tFUk5FTCk7DQo+ICsJ
dGd0LT5jcSA9IGt6YWxsb2ModGd0LT5jcV9tZW1fc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICAg
CWlmICghdGd0LT5jcSkgew0KPiAtCQlwcmludGsoS0VSTl9FUlIgUEZYICJ1bmFibGUgdG8g
YWxsb2NhdGUgQ1EgbWVtb3J5ICVkXG4iLA0KPiAtCQkJdGd0LT5jcV9tZW1fc2l6ZSk7DQo+
IC0JCWdvdG8gbWVtX2FsbG9jX2ZhaWx1cmU7DQo+ICsJCXByX2VycihQRlggInVuYWJsZSB0
byBhbGxvY2F0ZSBDUSBtZW1vcnkgJWRcbiIsDQo+ICsJCSAgICAgICB0Z3QtPmNxX21lbV9z
aXplKTsNCj4gKwkJZ290byBjcV9hbGxvY19mYWlsdXJlOw0KPiArCX0NCj4gKw0KPiArCXRn
dC0+Y3FfZG1hID0gZG1hX21hcF9zaW5nbGUoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+Y3Es
DQo+ICsJCQkJICAgICB0Z3QtPmNxX21lbV9zaXplLCBETUFfQklESVJFQ1RJT05BTCk7DQo+
ICsJaWYgKHVubGlrZWx5KGRtYV9tYXBwaW5nX2Vycm9yKCZoYmEtPnBjaWRldi0+ZGV2LCB0
Z3QtPmNxX2RtYSkpKSB7DQo+ICsJCXByX2VycihQRlggInVuYWJsZSB0byBtYXAgQ1EgbWVt
b3J5ICVkXG4iLCB0Z3QtPmNxX21lbV9zaXplKTsNCj4gKwkJZ290byBjcV9tYXBfZmFpbHVy
ZTsNCj4gICAJfQ0KPiAgIA0KPiAgIAkvKiBBbGxvY2F0ZSBhbmQgbWFwIFJRIGFuZCBSUSBQ
QkwgKi8NCj4gQEAgLTY5NywyNCArNzA5LDM2IEBAIHN0YXRpYyBpbnQgYm54MmZjX2FsbG9j
X3Nlc3Npb25fcmVzYyhzdHJ1Y3QgYm54MmZjX2hiYSAqaGJhLA0KPiAgIAl0Z3QtPnJxX21l
bV9zaXplID0gKHRndC0+cnFfbWVtX3NpemUgKyAoQ05JQ19QQUdFX1NJWkUgLSAxKSkgJg0K
PiAgIAkJCSAgIENOSUNfUEFHRV9NQVNLOw0KPiAgIA0KPiAtCXRndC0+cnEgPSBkbWFfYWxs
b2NfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+cnFfbWVtX3NpemUsDQo+IC0J
CQkJICAgICAmdGd0LT5ycV9kbWEsIEdGUF9LRVJORUwpOw0KPiArCXRndC0+cnEgPSBremFs
bG9jKHRndC0+cnFfbWVtX3NpemUsIEdGUF9LRVJORUwpOw0KPiAgIAlpZiAoIXRndC0+cnEp
IHsNCj4gLQkJcHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxlIHRvIGFsbG9jYXRlIFJRIG1l
bW9yeSAlZFxuIiwNCj4gLQkJCXRndC0+cnFfbWVtX3NpemUpOw0KPiAtCQlnb3RvIG1lbV9h
bGxvY19mYWlsdXJlOw0KPiArCQlwcl9lcnIoUEZYICJ1bmFibGUgdG8gYWxsb2NhdGUgUlEg
bWVtb3J5ICVkXG4iLA0KPiArCQkgICAgICAgdGd0LT5ycV9tZW1fc2l6ZSk7DQo+ICsJCWdv
dG8gcnFfYWxsb2NfZmFpbHVyZTsNCj4gKwl9DQo+ICsNCj4gKwl0Z3QtPnJxX2RtYSA9IGRt
YV9tYXBfc2luZ2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPnJxLA0KPiArCQkJCSAgICAg
dGd0LT5ycV9tZW1fc2l6ZSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArCWlmICh1bmxpa2Vs
eShkbWFfbWFwcGluZ19lcnJvcigmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5ycV9kbWEpKSkg
ew0KPiArCQlwcl9lcnIoUEZYICJ1bmFibGUgdG8gbWFwIFJRIG1lbW9yeSAlZFxuIiwgdGd0
LT5ycV9tZW1fc2l6ZSk7DQo+ICsJCWdvdG8gcnFfbWFwX2ZhaWx1cmU7DQo+ICAgCX0NCj4g
ICANCj4gICAJdGd0LT5ycV9wYmxfc2l6ZSA9ICh0Z3QtPnJxX21lbV9zaXplIC8gQ05JQ19Q
QUdFX1NJWkUpICogc2l6ZW9mKHZvaWQgKik7DQo+ICAgCXRndC0+cnFfcGJsX3NpemUgPSAo
dGd0LT5ycV9wYmxfc2l6ZSArIChDTklDX1BBR0VfU0laRSAtIDEpKSAmDQo+ICAgCQkJICAg
Q05JQ19QQUdFX01BU0s7DQo+ICAgDQo+IC0JdGd0LT5ycV9wYmwgPSBkbWFfYWxsb2NfY29o
ZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+cnFfcGJsX3NpemUsDQo+IC0JCQkJCSAm
dGd0LT5ycV9wYmxfZG1hLCBHRlBfS0VSTkVMKTsNCj4gKwl0Z3QtPnJxX3BibCA9IGt6YWxs
b2ModGd0LT5ycV9wYmxfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICAgCWlmICghdGd0LT5ycV9w
YmwpIHsNCj4gLQkJcHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxlIHRvIGFsbG9jYXRlIFJR
IFBCTCAlZFxuIiwNCj4gLQkJCXRndC0+cnFfcGJsX3NpemUpOw0KPiAtCQlnb3RvIG1lbV9h
bGxvY19mYWlsdXJlOw0KPiArCQlwcl9lcnIoUEZYICJ1bmFibGUgdG8gYWxsb2NhdGUgUlEg
UEJMICVkXG4iLCB0Z3QtPnJxX3BibF9zaXplKTsNCj4gKwkJZ290byBycV9wYmxfYWxsb2Nf
ZmFpbHVyZTsNCj4gKwl9DQo+ICsNCj4gKwl0Z3QtPnJxX3BibF9kbWEgPSBkbWFfbWFwX3Np
bmdsZSgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5ycV9wYmwsDQo+ICsJCQkJCSB0Z3QtPnJx
X3BibF9zaXplLCBETUFfQklESVJFQ1RJT05BTCk7DQo+ICsJaWYgKHVubGlrZWx5KGRtYV9t
YXBwaW5nX2Vycm9yKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPnJxX3BibF9kbWEpKSkgew0K
PiArCQlwcl9lcnIoUEZYICJ1bmFibGUgdG8gbWFwIFJRIFBCTCBtZW1vcnkgJWRcbiIsDQo+
ICsJCSAgICAgICB0Z3QtPnJxX3BibF9zaXplKTsNCj4gKwkJZ290byBycV9wYmxfbWFwX2Zh
aWx1cmU7DQo+ICAgCX0NCj4gICANCj4gICAJbnVtX3BhZ2VzID0gdGd0LT5ycV9tZW1fc2l6
ZSAvIENOSUNfUEFHRV9TSVpFOw0KPiBAQCAtNzM0LDEzICs3NTgsMTkgQEAgc3RhdGljIGlu
dCBibngyZmNfYWxsb2Nfc2Vzc2lvbl9yZXNjKHN0cnVjdCBibngyZmNfaGJhICpoYmEsDQo+
ICAgCXRndC0+eGZlcnFfbWVtX3NpemUgPSAodGd0LT54ZmVycV9tZW1fc2l6ZSArIChDTklD
X1BBR0VfU0laRSAtIDEpKSAmDQo+ICAgCQkJICAgICAgIENOSUNfUEFHRV9NQVNLOw0KPiAg
IA0KPiAtCXRndC0+eGZlcnEgPSBkbWFfYWxsb2NfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5k
ZXYsDQo+IC0JCQkJCXRndC0+eGZlcnFfbWVtX3NpemUsICZ0Z3QtPnhmZXJxX2RtYSwNCj4g
LQkJCQkJR0ZQX0tFUk5FTCk7DQo+ICsJdGd0LT54ZmVycSA9IGt6YWxsb2ModGd0LT54ZmVy
cV9tZW1fc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICAgCWlmICghdGd0LT54ZmVycSkgew0KPiAg
IAkJcHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxlIHRvIGFsbG9jYXRlIFhGRVJRICVkXG4i
LA0KPiAgIAkJCXRndC0+eGZlcnFfbWVtX3NpemUpOw0KPiAtCQlnb3RvIG1lbV9hbGxvY19m
YWlsdXJlOw0KPiArCQlnb3RvIHhmZXJxX2FsbG9jX2ZhaWx1cmU7DQo+ICsJfQ0KPiArDQo+
ICsJdGd0LT54ZmVycV9kbWEgPSBkbWFfbWFwX3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwg
dGd0LT54ZmVycSwNCj4gKwkJCQkJdGd0LT54ZmVycV9tZW1fc2l6ZSwgRE1BX0JJRElSRUNU
SU9OQUwpOw0KPiArCWlmICh1bmxpa2VseShkbWFfbWFwcGluZ19lcnJvcigmaGJhLT5wY2lk
ZXYtPmRldiwgdGd0LT54ZmVycV9kbWEpKSkgew0KPiArCQlwcl9lcnIoUEZYICJ1bmFibGUg
dG8gbWFwIFhGRVJRIG1lbW9yeSAlZFxuIiwNCj4gKwkJICAgICAgIHRndC0+eGZlcnFfbWVt
X3NpemUpOw0KPiArCQlnb3RvIHhmZXJxX21hcF9mYWlsdXJlOw0KPiAgIAl9DQo+ICAgDQo+
ICAgCS8qIEFsbG9jYXRlIGFuZCBtYXAgQ09ORlEgJiBDT05GUSBQQkwgKi8NCj4gQEAgLTc0
OCwxMyArNzc4LDE5IEBAIHN0YXRpYyBpbnQgYm54MmZjX2FsbG9jX3Nlc3Npb25fcmVzYyhz
dHJ1Y3QgYm54MmZjX2hiYSAqaGJhLA0KPiAgIAl0Z3QtPmNvbmZxX21lbV9zaXplID0gKHRn
dC0+Y29uZnFfbWVtX3NpemUgKyAoQ05JQ19QQUdFX1NJWkUgLSAxKSkgJg0KPiAgIAkJCSAg
ICAgICBDTklDX1BBR0VfTUFTSzsNCj4gICANCj4gLQl0Z3QtPmNvbmZxID0gZG1hX2FsbG9j
X2NvaGVyZW50KCZoYmEtPnBjaWRldi0+ZGV2LA0KPiAtCQkJCQl0Z3QtPmNvbmZxX21lbV9z
aXplLCAmdGd0LT5jb25mcV9kbWEsDQo+IC0JCQkJCUdGUF9LRVJORUwpOw0KPiArCXRndC0+
Y29uZnEgPSBremFsbG9jKHRndC0+Y29uZnFfbWVtX3NpemUsIEdGUF9LRVJORUwpOw0KPiAg
IAlpZiAoIXRndC0+Y29uZnEpIHsNCj4gLQkJcHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxl
IHRvIGFsbG9jYXRlIENPTkZRICVkXG4iLA0KPiAtCQkJdGd0LT5jb25mcV9tZW1fc2l6ZSk7
DQo+IC0JCWdvdG8gbWVtX2FsbG9jX2ZhaWx1cmU7DQo+ICsJCXByX2VycihQRlggInVuYWJs
ZSB0byBhbGxvY2F0ZSBDT05GUSAlZFxuIiwNCj4gKwkJICAgICAgIHRndC0+Y29uZnFfbWVt
X3NpemUpOw0KPiArCQlnb3RvIGNvbmZxX2FsbG9jX2ZhaWx1cmU7DQo+ICsJfQ0KPiArDQo+
ICsJdGd0LT5jb25mcV9kbWEgPSBkbWFfbWFwX3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwg
dGd0LT5jb25mcSwNCj4gKwkJCQkJdGd0LT5jb25mcV9tZW1fc2l6ZSwgRE1BX0JJRElSRUNU
SU9OQUwpOw0KPiArCWlmICh1bmxpa2VseShkbWFfbWFwcGluZ19lcnJvcigmaGJhLT5wY2lk
ZXYtPmRldiwgdGd0LT5jb25mcV9kbWEpKSkgew0KPiArCQlwcl9lcnIoUEZYICJ1bmFibGUg
dG8gbWFwIENPTkZRIG1lbW9yeSAlZFxuIiwNCj4gKwkJICAgICAgIHRndC0+Y29uZnFfbWVt
X3NpemUpOw0KPiArCQlnb3RvIGNvbmZxX21hcF9mYWlsdXJlOw0KPiAgIAl9DQo+ICAgDQo+
ICAgCXRndC0+Y29uZnFfcGJsX3NpemUgPQ0KPiBAQCAtNzYyLDEzICs3OTgsMTkgQEAgc3Rh
dGljIGludCBibngyZmNfYWxsb2Nfc2Vzc2lvbl9yZXNjKHN0cnVjdCBibngyZmNfaGJhICpo
YmEsDQo+ICAgCXRndC0+Y29uZnFfcGJsX3NpemUgPQ0KPiAgIAkJKHRndC0+Y29uZnFfcGJs
X3NpemUgKyAoQ05JQ19QQUdFX1NJWkUgLSAxKSkgJiBDTklDX1BBR0VfTUFTSzsNCj4gICAN
Cj4gLQl0Z3QtPmNvbmZxX3BibCA9IGRtYV9hbGxvY19jb2hlcmVudCgmaGJhLT5wY2lkZXYt
PmRldiwNCj4gLQkJCQkJICAgIHRndC0+Y29uZnFfcGJsX3NpemUsDQo+IC0JCQkJCSAgICAm
dGd0LT5jb25mcV9wYmxfZG1hLCBHRlBfS0VSTkVMKTsNCj4gKwl0Z3QtPmNvbmZxX3BibCA9
IGt6YWxsb2ModGd0LT5jb25mcV9wYmxfc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ICAgCWlmICgh
dGd0LT5jb25mcV9wYmwpIHsNCj4gLQkJcHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxlIHRv
IGFsbG9jYXRlIENPTkZRIFBCTCAlZFxuIiwNCj4gLQkJCXRndC0+Y29uZnFfcGJsX3NpemUp
Ow0KPiAtCQlnb3RvIG1lbV9hbGxvY19mYWlsdXJlOw0KPiArCQlwcl9lcnIoUEZYICJ1bmFi
bGUgdG8gYWxsb2NhdGUgQ09ORlEgUEJMICVkXG4iLA0KPiArCQkgICAgICAgdGd0LT5jb25m
cV9wYmxfc2l6ZSk7DQo+ICsJCWdvdG8gY29uZnFfcGJsX2FsbG9jX2ZhaWx1cmU7DQo+ICsJ
fQ0KPiArDQo+ICsJdGd0LT5jb25mcV9wYmxfZG1hID0gZG1hX21hcF9zaW5nbGUoJmhiYS0+
cGNpZGV2LT5kZXYsIHRndC0+Y29uZnFfcGJsLA0KPiArCQkJCQkgICAgdGd0LT5jb25mcV9w
Ymxfc2l6ZSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArCWlmICh1bmxpa2VseShkbWFfbWFw
cGluZ19lcnJvcigmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5jb25mcV9wYmxfZG1hKSkpIHsN
Cj4gKwkJcHJfZXJyKFBGWCAidW5hYmxlIHRvIG1hcCBDT05GUSBQQkwgbWVtb3J5ICVkXG4i
LA0KPiArCQkgICAgICAgdGd0LT5jb25mcV9wYmxfc2l6ZSk7DQo+ICsJCWdvdG8gY29uZnFf
cGJsX21hcF9mYWlsdXJlOw0KPiAgIAl9DQo+ICAgDQo+ICAgCW51bV9wYWdlcyA9IHRndC0+
Y29uZnFfbWVtX3NpemUgLyBDTklDX1BBR0VfU0laRTsNCj4gQEAgLTc4NiwzNSArODI4LDg4
IEBAIHN0YXRpYyBpbnQgYm54MmZjX2FsbG9jX3Nlc3Npb25fcmVzYyhzdHJ1Y3QgYm54MmZj
X2hiYSAqaGJhLA0KPiAgIAkvKiBBbGxvY2F0ZSBhbmQgbWFwIENvbm5EQiAqLw0KPiAgIAl0
Z3QtPmNvbm5fZGJfbWVtX3NpemUgPSBzaXplb2Yoc3RydWN0IGZjb2VfY29ubl9kYik7DQo+
ICAgDQo+IC0JdGd0LT5jb25uX2RiID0gZG1hX2FsbG9jX2NvaGVyZW50KCZoYmEtPnBjaWRl
di0+ZGV2LA0KPiAtCQkJCQkgIHRndC0+Y29ubl9kYl9tZW1fc2l6ZSwNCj4gLQkJCQkJICAm
dGd0LT5jb25uX2RiX2RtYSwgR0ZQX0tFUk5FTCk7DQo+ICsJdGd0LT5jb25uX2RiID0ga3ph
bGxvYyh0Z3QtPmNvbm5fZGJfbWVtX3NpemUsIEdGUF9LRVJORUwpOw0KPiAgIAlpZiAoIXRn
dC0+Y29ubl9kYikgew0KPiAgIAkJcHJpbnRrKEtFUk5fRVJSIFBGWCAidW5hYmxlIHRvIGFs
bG9jYXRlIGNvbm5fZGIgJWRcbiIsDQo+IC0JCQkJCQl0Z3QtPmNvbm5fZGJfbWVtX3NpemUp
Ow0KPiAtCQlnb3RvIG1lbV9hbGxvY19mYWlsdXJlOw0KPiArCQkgICAgICAgdGd0LT5jb25u
X2RiX21lbV9zaXplKTsNCj4gKwkJZ290byBjb25uX2RiX2FsbG9jX2ZhaWx1cmU7DQo+ICAg
CX0NCj4gICANCj4gKwl0Z3QtPmNvbm5fZGJfZG1hID0gZG1hX21hcF9zaW5nbGUoJmhiYS0+
cGNpZGV2LT5kZXYsIHRndC0+Y29ubl9kYiwNCj4gKwkJCQkJICB0Z3QtPmNvbm5fZGJfbWVt
X3NpemUsIERNQV9CSURJUkVDVElPTkFMKTsNCj4gKwlpZiAodW5saWtlbHkoZG1hX21hcHBp
bmdfZXJyb3IoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+Y29ubl9kYl9kbWEpKSkgew0KPiAr
CQlwcl9lcnIoUEZYICJ1bmFibGUgdG8gbWFwIGNvbm4gZGIgbWVtb3J5ICVkXG4iLA0KPiAr
CQkgICAgICAgdGd0LT5jb25uX2RiX21lbV9zaXplKTsNCj4gKwkJZ290byBjb25uX2RiX21h
cF9mYWlsdXJlOw0KPiArCX0NCj4gICANCj4gICAJLyogQWxsb2NhdGUgYW5kIG1hcCBMQ1Eg
Ki8NCj4gICAJdGd0LT5sY3FfbWVtX3NpemUgPSAodGd0LT5tYXhfc3FlcyArIDgpICogQk5Y
MkZDX1NRX1dRRV9TSVpFOw0KPiAgIAl0Z3QtPmxjcV9tZW1fc2l6ZSA9ICh0Z3QtPmxjcV9t
ZW1fc2l6ZSArIChDTklDX1BBR0VfU0laRSAtIDEpKSAmDQo+ICAgCQkJICAgICBDTklDX1BB
R0VfTUFTSzsNCj4gICANCj4gLQl0Z3QtPmxjcSA9IGRtYV9hbGxvY19jb2hlcmVudCgmaGJh
LT5wY2lkZXYtPmRldiwgdGd0LT5sY3FfbWVtX3NpemUsDQo+IC0JCQkJICAgICAgJnRndC0+
bGNxX2RtYSwgR0ZQX0tFUk5FTCk7DQo+IC0NCj4gKwl0Z3QtPmxjcSA9IGt6YWxsb2ModGd0
LT5sY3FfbWVtX3NpemUsIEdGUF9LRVJORUwpOw0KPiAgIAlpZiAoIXRndC0+bGNxKSB7DQo+
ICAgCQlwcmludGsoS0VSTl9FUlIgUEZYICJ1bmFibGUgdG8gYWxsb2NhdGUgbGNxICVkXG4i
LA0KPiAgIAkJICAgICAgIHRndC0+bGNxX21lbV9zaXplKTsNCj4gLQkJZ290byBtZW1fYWxs
b2NfZmFpbHVyZTsNCj4gKwkJZ290byBsY3FfYWxsb2NfZmFpbHVyZTsNCj4gKwl9DQo+ICsN
Cj4gKwl0Z3QtPmxjcV9kbWEgPSBkbWFfbWFwX3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwg
dGd0LT5sY3EsDQo+ICsJCQkJICAgICAgdGd0LT5sY3FfbWVtX3NpemUsIERNQV9CSURJUkVD
VElPTkFMKTsNCj4gKwlpZiAodW5saWtlbHkoZG1hX21hcHBpbmdfZXJyb3IoJmhiYS0+cGNp
ZGV2LT5kZXYsIHRndC0+bGNxX2RtYSkpKSB7DQo+ICsJCXByX2VycihQRlggInVuYWJsZSB0
byBtYXAgbGNxIG1lbW9yeSAlZFxuIiwNCj4gKwkJICAgICAgIHRndC0+bGNxX21lbV9zaXpl
KTsNCj4gKwkJZ290byBsY3FfbWFwX2ZhaWx1cmU7DQo+ICAgCX0NCj4gICANCj4gICAJdGd0
LT5jb25uX2RiLT5ycV9wcm9kID0gMHg4MDAwOw0KPiAgIA0KPiAgIAlyZXR1cm4gMDsNCj4g
ICANCj4gLW1lbV9hbGxvY19mYWlsdXJlOg0KPiArbGNxX21hcF9mYWlsdXJlOg0KPiArCWtm
cmVlKHRndC0+bGNxKTsNCj4gK2xjcV9hbGxvY19mYWlsdXJlOg0KPiArCWRtYV91bm1hcF9z
aW5nbGUoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+Y29ubl9kYl9kbWEsDQo+ICsJCQkgdGd0
LT5jb25uX2RiX21lbV9zaXplLCBETUFfQklESVJFQ1RJT05BTCk7DQo+ICtjb25uX2RiX21h
cF9mYWlsdXJlOg0KPiArCWtmcmVlKHRndC0+Y29ubl9kYik7DQo+ICtjb25uX2RiX2FsbG9j
X2ZhaWx1cmU6DQo+ICsJZG1hX3VubWFwX3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwgdGd0
LT5jb25mcV9wYmxfZG1hLA0KPiArCQkJIHRndC0+Y29uZnFfcGJsX3NpemUsIERNQV9CSURJ
UkVDVElPTkFMKTsNCj4gK2NvbmZxX3BibF9tYXBfZmFpbHVyZToNCj4gKwlrZnJlZSh0Z3Qt
PmNvbmZxX3BibCk7DQo+ICtjb25mcV9wYmxfYWxsb2NfZmFpbHVyZToNCj4gKwlkbWFfdW5t
YXBfc2luZ2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPmNvbmZxX2RtYSwNCj4gKwkJCSB0
Z3QtPmNvbmZxX21lbV9zaXplLCBETUFfQklESVJFQ1RJT05BTCk7DQo+ICtjb25mcV9tYXBf
ZmFpbHVyZToNCj4gKwlrZnJlZSh0Z3QtPmNvbmZxKTsNCj4gK2NvbmZxX2FsbG9jX2ZhaWx1
cmU6DQo+ICsJZG1hX3VubWFwX3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT54ZmVy
cV9kbWEsDQo+ICsJCQkgdGd0LT54ZmVycV9tZW1fc2l6ZSwgRE1BX0JJRElSRUNUSU9OQUwp
Ow0KPiAreGZlcnFfbWFwX2ZhaWx1cmU6DQo+ICsJa2ZyZWUodGd0LT54ZmVycSk7DQo+ICt4
ZmVycV9hbGxvY19mYWlsdXJlOg0KPiArCWRtYV91bm1hcF9zaW5nbGUoJmhiYS0+cGNpZGV2
LT5kZXYsIHRndC0+cnFfcGJsX2RtYSwNCj4gKwkJCSB0Z3QtPnJxX3BibF9zaXplLCBETUFf
QklESVJFQ1RJT05BTCk7DQo+ICtycV9wYmxfbWFwX2ZhaWx1cmU6DQo+ICsJa2ZyZWUodGd0
LT5ycV9wYmwpOw0KPiArcnFfcGJsX2FsbG9jX2ZhaWx1cmU6DQo+ICsJZG1hX3VubWFwX3Np
bmdsZSgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5ycV9kbWEsIHRndC0+cnFfbWVtX3NpemUs
DQo+ICsJCQkgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArcnFfbWFwX2ZhaWx1cmU6DQo+ICsJ
a2ZyZWUodGd0LT5ycSk7DQo+ICtycV9hbGxvY19mYWlsdXJlOg0KPiArCWRtYV91bm1hcF9z
aW5nbGUoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+Y3FfZG1hLCB0Z3QtPmNxX21lbV9zaXpl
LA0KPiArCQkJIERNQV9CSURJUkVDVElPTkFMKTsNCj4gK2NxX21hcF9mYWlsdXJlOg0KPiAr
CWtmcmVlKHRndC0+Y3EpOw0KPiArY3FfYWxsb2NfZmFpbHVyZToNCj4gKwlkbWFfdW5tYXBf
c2luZ2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPnNxX2RtYSwgdGd0LT5zcV9tZW1fc2l6
ZSwNCj4gKwkJCSBETUFfQklESVJFQ1RJT05BTCk7DQo+ICtzcV9tYXBfZmFpbHVyZToNCj4g
KwlrZnJlZSh0Z3QtPnNxKTsNCj4gK3NxX2FsbG9jX2ZhaWx1cmU6DQo+ICAgCXJldHVybiAt
RU5PTUVNOw0KPiAgIH0NCj4gICANCj4gQEAgLTgzOSw1NCArOTM0LDYzIEBAIHN0YXRpYyB2
b2lkIGJueDJmY19mcmVlX3Nlc3Npb25fcmVzYyhzdHJ1Y3QgYm54MmZjX2hiYSAqaGJhLA0K
PiAgIA0KPiAgIAkvKiBGcmVlIExDUSAqLw0KPiAgIAlpZiAodGd0LT5sY3EpIHsNCj4gLQkJ
ZG1hX2ZyZWVfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+bGNxX21lbV9zaXpl
LA0KPiAtCQkJCSAgICB0Z3QtPmxjcSwgdGd0LT5sY3FfZG1hKTsNCj4gKwkJZG1hX3VubWFw
X3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5sY3FfZG1hLA0KPiArCQkJCSB0Z3Qt
PmxjcV9tZW1fc2l6ZSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArCQlrZnJlZSh0Z3QtPmxj
cSk7DQo+ICAgCQl0Z3QtPmxjcSA9IE5VTEw7DQo+ICAgCX0NCj4gICAJLyogRnJlZSBjb25u
REIgKi8NCj4gICAJaWYgKHRndC0+Y29ubl9kYikgew0KPiAtCQlkbWFfZnJlZV9jb2hlcmVu
dCgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5jb25uX2RiX21lbV9zaXplLA0KPiAtCQkJCSAg
ICB0Z3QtPmNvbm5fZGIsIHRndC0+Y29ubl9kYl9kbWEpOw0KPiArCQlkbWFfdW5tYXBfc2lu
Z2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPmNvbm5fZGJfZG1hLA0KPiArCQkJCSB0Z3Qt
PmNvbm5fZGJfbWVtX3NpemUsIERNQV9CSURJUkVDVElPTkFMKTsNCj4gKwkJa2ZyZWUodGd0
LT5jb25uX2RiKTsNCj4gICAJCXRndC0+Y29ubl9kYiA9IE5VTEw7DQo+ICAgCX0NCj4gICAJ
LyogRnJlZSBjb25mcSAgYW5kIGNvbmZxIHBibCAqLw0KPiAgIAlpZiAodGd0LT5jb25mcV9w
YmwpIHsNCj4gLQkJZG1hX2ZyZWVfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+
Y29uZnFfcGJsX3NpemUsDQo+IC0JCQkJICAgIHRndC0+Y29uZnFfcGJsLCB0Z3QtPmNvbmZx
X3BibF9kbWEpOw0KPiArCQlkbWFfdW5tYXBfc2luZ2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0
Z3QtPmNvbmZxX3BibF9kbWEsDQo+ICsJCQkJIHRndC0+Y29uZnFfcGJsX3NpemUsIERNQV9C
SURJUkVDVElPTkFMKTsNCj4gKwkJa2ZyZWUodGd0LT5jb25mcV9wYmwpOw0KPiAgIAkJdGd0
LT5jb25mcV9wYmwgPSBOVUxMOw0KPiAgIAl9DQo+ICAgCWlmICh0Z3QtPmNvbmZxKSB7DQo+
IC0JCWRtYV9mcmVlX2NvaGVyZW50KCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPmNvbmZxX21l
bV9zaXplLA0KPiAtCQkJCSAgICB0Z3QtPmNvbmZxLCB0Z3QtPmNvbmZxX2RtYSk7DQo+ICsJ
CWRtYV91bm1hcF9zaW5nbGUoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+Y29uZnFfZG1hLA0K
PiArCQkJCSB0Z3QtPmNvbmZxX21lbV9zaXplLCBETUFfQklESVJFQ1RJT05BTCk7DQo+ICsJ
CWtmcmVlKHRndC0+Y29uZnEpOw0KPiAgIAkJdGd0LT5jb25mcSA9IE5VTEw7DQo+ICAgCX0N
Cj4gICAJLyogRnJlZSBYRkVSUSAqLw0KPiAgIAlpZiAodGd0LT54ZmVycSkgew0KPiAtCQlk
bWFfZnJlZV9jb2hlcmVudCgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT54ZmVycV9tZW1fc2l6
ZSwNCj4gLQkJCQkgICAgdGd0LT54ZmVycSwgdGd0LT54ZmVycV9kbWEpOw0KPiArCQlkbWFf
dW5tYXBfc2luZ2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPnhmZXJxX2RtYSwNCj4gKwkJ
CQkgdGd0LT54ZmVycV9tZW1fc2l6ZSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArCQlrZnJl
ZSh0Z3QtPnhmZXJxKTsNCj4gICAJCXRndC0+eGZlcnEgPSBOVUxMOw0KPiAgIAl9DQo+ICAg
CS8qIEZyZWUgUlEgUEJMIGFuZCBSUSAqLw0KPiAgIAlpZiAodGd0LT5ycV9wYmwpIHsNCj4g
LQkJZG1hX2ZyZWVfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+cnFfcGJsX3Np
emUsDQo+IC0JCQkJICAgIHRndC0+cnFfcGJsLCB0Z3QtPnJxX3BibF9kbWEpOw0KPiArCQlk
bWFfdW5tYXBfc2luZ2xlKCZoYmEtPnBjaWRldi0+ZGV2LCB0Z3QtPnJxX3BibF9kbWEsDQo+
ICsJCQkJIHRndC0+cnFfcGJsX3NpemUsIERNQV9CSURJUkVDVElPTkFMKTsNCj4gKwkJa2Zy
ZWUodGd0LT5ycV9wYmwpOw0KPiAgIAkJdGd0LT5ycV9wYmwgPSBOVUxMOw0KPiAgIAl9DQo+
ICAgCWlmICh0Z3QtPnJxKSB7DQo+IC0JCWRtYV9mcmVlX2NvaGVyZW50KCZoYmEtPnBjaWRl
di0+ZGV2LCB0Z3QtPnJxX21lbV9zaXplLA0KPiAtCQkJCSAgICB0Z3QtPnJxLCB0Z3QtPnJx
X2RtYSk7DQo+ICsJCWRtYV91bm1hcF9zaW5nbGUoJmhiYS0+cGNpZGV2LT5kZXYsIHRndC0+
cnFfZG1hLA0KPiArCQkJCSB0Z3QtPnJxX21lbV9zaXplLCBETUFfQklESVJFQ1RJT05BTCk7
DQo+ICsJCWtmcmVlKHRndC0+cnEpOw0KPiAgIAkJdGd0LT5ycSA9IE5VTEw7DQo+ICAgCX0N
Cj4gICAJLyogRnJlZSBDUSAqLw0KPiAgIAlpZiAodGd0LT5jcSkgew0KPiAtCQlkbWFfZnJl
ZV9jb2hlcmVudCgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5jcV9tZW1fc2l6ZSwNCj4gLQkJ
CQkgICAgdGd0LT5jcSwgdGd0LT5jcV9kbWEpOw0KPiArCQlkbWFfdW5tYXBfc2luZ2xlKCZo
YmEtPnBjaWRldi0+ZGV2LCB0Z3QtPmNxX2RtYSwNCj4gKwkJCQkgdGd0LT5jcV9tZW1fc2l6
ZSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiArCQlrZnJlZSh0Z3QtPmNxKTsNCj4gICAJCXRn
dC0+Y3EgPSBOVUxMOw0KPiAgIAl9DQo+ICAgCS8qIEZyZWUgU1EgKi8NCj4gICAJaWYgKHRn
dC0+c3EpIHsNCj4gLQkJZG1hX2ZyZWVfY29oZXJlbnQoJmhiYS0+cGNpZGV2LT5kZXYsIHRn
dC0+c3FfbWVtX3NpemUsDQo+IC0JCQkJICAgIHRndC0+c3EsIHRndC0+c3FfZG1hKTsNCj4g
KwkJZG1hX3VubWFwX3NpbmdsZSgmaGJhLT5wY2lkZXYtPmRldiwgdGd0LT5zcV9kbWEsDQo+
ICsJCQkJIHRndC0+c3FfbWVtX3NpemUsIERNQV9CSURJUkVDVElPTkFMKTsNCj4gKwkJa2Zy
ZWUodGd0LT5zcSk7DQo+ICAgCQl0Z3QtPnNxID0gTlVMTDsNCj4gICAJfQ0KPiAgIAlzcGlu
X3VubG9ja19iaCgmdGd0LT5jcV9sb2NrKTsNCg==

