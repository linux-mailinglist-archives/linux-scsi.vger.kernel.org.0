Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27796CB560
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Mar 2023 06:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC1ETS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Mar 2023 00:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1ETR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Mar 2023 00:19:17 -0400
X-Greylist: delayed 1810 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 21:19:14 PDT
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEBF4E0
        for <linux-scsi@vger.kernel.org>; Mon, 27 Mar 2023 21:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=LupgT4ABXdRylNRpeA7WerF9P7B4dIyFRwZvT7wt8zE=; b=g
        4ZCwSAj4yhA+ATw6gUfO/U+b5FoXsiQ7uyMBxvdALpxcWgQwV5MrZZmvJP3pdHFe
        DAKeQQh+Ti5z5lxkkqzxLFYBWEkM2rpforOwgWmF0RR6Q4/p1sIrlX/FI5L7eh/w
        0X6MZctF2axrkvN5CBFHthN2m3IsyAZPXrh4UUtn0U=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Tue, 28 Mar 2023 11:47:52 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Tue, 28 Mar 2023 11:47:52 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Justin Tee" <justintee8345@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Subject: Re:Re: [PATCH] scsi: lpfc: Fix potential memory leak
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
In-Reply-To: <CABPRKS9dqusoWNWSOE0B87VrrFR5JR9otydPVQRMRddXQCt-6A@mail.gmail.com>
References: <20230317015602.1748372-1-windhl@126.com>
 <CABPRKS9dqusoWNWSOE0B87VrrFR5JR9otydPVQRMRddXQCt-6A@mail.gmail.com>
X-NTES-SC: AL_QuycC/Wcukos5CWeYekXnkwQhu05Ucq4u/8l1YVVP5E0uCrP3D8dZ3hcHWLY//C3Mh+Ttx+OSj1SysV2QLVncIkjhUAedhQ4ZVLsHpaWToo3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <16832d4f.3373.18726545077.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowACHj6tpYyJk6yACAA--.18661W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi5hxAF2IxlTUAwgACse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

CkF0IDIwMjMtMDMtMjggMDI6Mzk6MzgsICJKdXN0aW4gVGVlIiA8anVzdGludGVlODM0NUBnbWFp
bC5jb20+IHdyb3RlOgo+SGkgTGlhbmcsCj4KPkBAIC0xMjAwLDYgKzEyMDAsMTEgQEAgbHBmY19i
c2dfaGJhX3NldF9ldmVudChzdHJ1Y3QgYnNnX2pvYiAqam9iKQo+ICAgICAgICBzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZwaGJhLT5jdF9ldl9sb2NrLCBmbGFncyk7Cj4KPiAgICAgICAgaWYgKCZl
dnQtPm5vZGUgPT0gJnBoYmEtPmN0X2V2X3dhaXRlcnMpIHsKPisKPisgICAgICAgICAgICAgICBz
cGluX2xvY2tfaXJxc2F2ZSgmcGhiYS0+Y3RfZXZfbG9jaywgZmxhZ3MpOwo+KyAgICAgICAgICAg
ICAgIGxwZmNfYnNnX2V2ZW50X3VucmVmKGV2dCk7Cj4rICAgICAgICAgICAgICAgc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmcGhiYS0+Y3RfZXZfbG9jaywgZmxhZ3MpOwo+Kwo+ICAgICAgICAgICAg
ICAgIC8qIG5vIGV2ZW50IHdhaXRpbmcgc3RydWN0IHlldCAtIGZpcnN0IGNhbGwgKi8KPiAgICAg
ICAgICAgICAgICBkZF9kYXRhID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGJzZ19qb2JfZGF0YSks
IEdGUF9LRVJORUwpOwo+ICAgICAgICAgICAgICAgIGlmIChkZF9kYXRhID09IE5VTEwpIHsKPgo+
aWYgKCZldnQtPm5vZGUgPT0gJnBoYmEtPmN0X2V2X3dhaXRlcnMpIHdhcyB0cnVlLCB0aGVuIHRo
YXQgbWVhbnMgdGhlCj5jdF9ldl93YWl0ZXJzIGxpc3Qgd2FzIGVtcHR5IHNvIHRoZSAqZXZ0IHB0
ciBpcyBub3QgcG9pbnRpbmcgdG8gYSByZWFsCj5scGZjX2JzZ19ldmVudCBzdHJ1Y3R1cmUuICBJ
IHRoaW5rIHdlIHdvdWxkIGV2ZW4gY3Jhc2ggdHJ5aW5nIHRvCj5kZWNyZW1lbnQgZXZ04oCZcyBr
cmVmIGJlY2F1c2UgZXZ0IGlzIGFuIHVuaW5pdGlhbGl6ZWQgbHBmY19ic2dfZXZlbnQKPnN0cnVj
dHVyZSBhbmQgbm90IHBvaW50aW5nIHRvIGFueXRoaW5nIHJlYWwuICBXZeKAmXJlIGFib3V0IHRv
IGt6YWxsb2MgYQo+bmV3IGV2dCB3aXRoIGxwZmNfYnNnX2V2ZW50X25ldyBpbiB0aGlzIHNhbWUg
aWYgc3RhdGVtZW50IGNsYXVzZQo+YW55d2F5cy4gIEnigJltIG5vdCBjbGVhciBvbiB0aGUgcmVh
c29uaW5nIGJlaGluZCB0aGUgc3VnZ2VzdGlvbiB0byBjYWxsCj5scGZjX2JzZ19ldmVudF91bnJl
ZihldnQpIHRoZXJlLgo+Cj4KPkBAIC0xMjkyLDYgKzEyOTcsOSBAQCBscGZjX2JzZ19oYmFfZ2V0
X2V2ZW50KHN0cnVjdCBic2dfam9iICpqb2IpCj4gICAgICAgICAqIGFuIGVycm9yIGluZGljYXRp
bmcgdGhhdCB0aGVyZSBpc24ndCBhbnltb3JlCj4gICAgICAgICAqLwo+ICAgICAgICBpZiAoZXZ0
X2RhdCA9PSBOVUxMKSB7Cj4rICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnBoYmEt
PmN0X2V2X2xvY2ssIGZsYWdzKTsKPisgICAgICAgICAgICAgICBscGZjX2JzZ19ldmVudF91bnJl
ZihldnQpOwo+KyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBoYmEtPmN0
X2V2X2xvY2ssIGZsYWdzKTsKPiAgICAgICAgICAgICAgICBic2dfcmVwbHktPnJlcGx5X3BheWxv
YWRfcmN2X2xlbiA9IDA7Cj4gICAgICAgICAgICAgICAgcmMgPSAtRU5PRU5UOwo+ICAgICAgICAg
ICAgICAgIGdvdG8gam9iX2Vycm9yOwo+Cj5TaW1pbGFyIGFyZ3VtZW50IGhlcmUuICBJZiAoZXZ0
X2RhdCA9PSBOVUxMKSB3YXMgdHJ1ZSwgdGhlbiB0aGF0IG1lYW5zCj50aGVyZSB3YXMgbm90aGlu
ZyBvZiBpbnRlcmVzdCBpbiB0aGUgY3RfZXZfd2FpdGVycyBsaXN0IG9yIHRoYXQgdGhlCj5jdF9l
dl93YWl0ZXJzIGxpc3Qgd2FzIGVtcHR5LiAgSW4gZWl0aGVyIGNhc2UsIHdlIHNob3VsZG7igJl0
IGNhbGwKPmxwZmNfYnNnX2V2ZW50X3VucmVmKGV2dCkgYmVjYXVzZSB3ZSB3b3VsZCBiZSBkZWNy
ZW1lbnRpbmcgdGhlIHdyb25nCj5yZWdfaWQgZXZ04oCZcyBrcmVmIG9yIGV2ZW4gY3Jhc2ggaWYg
dGhlIGN0X2V2X3dhaXRlcnMgbGlzdCB3YXMgZW1wdHkKPnRyeWluZyB0byBrcmVmX3B1dCBhbiB1
bmluaXRpYWxpemVkIGxwZmNfYnNnX2V2ZW50IHN0cnVjdHVyZS4KPgo+UmVnYXJkcywKPkp1c3Rp
bgoKSGksIEp1c3RpbiwKClRoYW5rcyBmb3IgeW91ciBraW5kbHkgZXhwbGFpbmF0aW9uLgoKTXkg
cGF0Y2ggaXMgaW5kZWVkIHdyb25nLCBhcyBJIGhhdmUgbm90IHJlYWxpemVkIHRoZSBzZW1hbnRp
YyBvZiAiJmV2dC0+bm9kZSA9PSAmcGhiYS0+Y3RfZXZfd2FpdGVycyIuCgpUaGFua3MgYW5kIHNv
cnJ5IGZvciBteSB0cm91YmxlLgoKTGlhbmcgCgoKPgo+T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQg
NzowMuKAr1BNIExpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+Cj4+IEluIGxwZmNf
YnNnX2hiYV9nZXRfZXZlbnQoKSBhbmQgbHBmY19ic2dfaGJhX3NldF9ldmVudCgpLCB3ZQo+PiBz
aG91bGQga2VlcCB0aGUgcmVmY291bnQgYmFsYW5jZSB3aGVuIHRoZXJlIGlzIHNvbWUgZXJyb3Ig
b3IKPj4gdGhlICpldnQqIHdpbGwgYmUgcmVwbGFjZWQuCj4+Cj4+IEZpeGVzOiBmMWMzYjBmY2Ji
ODEgKCJbU0NTSV0gbHBmYyA4LjMuNDogQWRkIGJzZyAoU0dJT3Y0KSBzdXBwb3J0IGZvciBFTFMv
Q1Qgc3VwcG9ydCIpCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4K
Pj4gLS0tCj4+ICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2JzZy5jIHwgOCArKysrKysrKwo+PiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zY3NpL2xwZmMvbHBmY19ic2cuYyBiL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfYnNnLmMKPj4g
aW5kZXggODUyYjAyNWUyZmVjLi5hYTUzNWJjMTQ3NTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
c2NzaS9scGZjL2xwZmNfYnNnLmMKPj4gKysrIGIvZHJpdmVycy9zY3NpL2xwZmMvbHBmY19ic2cu
Ywo+PiBAQCAtMTIwMCw2ICsxMjAwLDExIEBAIGxwZmNfYnNnX2hiYV9zZXRfZXZlbnQoc3RydWN0
IGJzZ19qb2IgKmpvYikKPj4gICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwaGJhLT5j
dF9ldl9sb2NrLCBmbGFncyk7Cj4+Cj4+ICAgICAgICAgaWYgKCZldnQtPm5vZGUgPT0gJnBoYmEt
PmN0X2V2X3dhaXRlcnMpIHsKPj4gKwo+PiArICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNh
dmUoJnBoYmEtPmN0X2V2X2xvY2ssIGZsYWdzKTsKPj4gKyAgICAgICAgICAgICAgIGxwZmNfYnNn
X2V2ZW50X3VucmVmKGV2dCk7Cj4+ICsgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZwaGJhLT5jdF9ldl9sb2NrLCBmbGFncyk7Cj4+ICsKPj4gICAgICAgICAgICAgICAgIC8q
IG5vIGV2ZW50IHdhaXRpbmcgc3RydWN0IHlldCAtIGZpcnN0IGNhbGwgKi8KPj4gICAgICAgICAg
ICAgICAgIGRkX2RhdGEgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgYnNnX2pvYl9kYXRhKSwgR0ZQ
X0tFUk5FTCk7Cj4+ICAgICAgICAgICAgICAgICBpZiAoZGRfZGF0YSA9PSBOVUxMKSB7Cj4+IEBA
IC0xMjkyLDYgKzEyOTcsOSBAQCBscGZjX2JzZ19oYmFfZ2V0X2V2ZW50KHN0cnVjdCBic2dfam9i
ICpqb2IpCj4+ICAgICAgICAgICogYW4gZXJyb3IgaW5kaWNhdGluZyB0aGF0IHRoZXJlIGlzbid0
IGFueW1vcmUKPj4gICAgICAgICAgKi8KPj4gICAgICAgICBpZiAoZXZ0X2RhdCA9PSBOVUxMKSB7
Cj4+ICsgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmcGhiYS0+Y3RfZXZfbG9jaywg
ZmxhZ3MpOwo+PiArICAgICAgICAgICAgICAgbHBmY19ic2dfZXZlbnRfdW5yZWYoZXZ0KTsKPj4g
KyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBoYmEtPmN0X2V2X2xvY2ss
IGZsYWdzKTsKPj4gICAgICAgICAgICAgICAgIGJzZ19yZXBseS0+cmVwbHlfcGF5bG9hZF9yY3Zf
bGVuID0gMDsKPj4gICAgICAgICAgICAgICAgIHJjID0gLUVOT0VOVDsKPj4gICAgICAgICAgICAg
ICAgIGdvdG8gam9iX2Vycm9yOwo+PiAtLQo+PiAyLjI1LjEKPj4K
