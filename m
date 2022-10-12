Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC05FCA35
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Oct 2022 20:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJLSDa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Oct 2022 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJLSD3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Oct 2022 14:03:29 -0400
Received: from antispam1.zonit.com (antispam1.zonit.com [192.88.205.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60731CAE7A
        for <linux-scsi@vger.kernel.org>; Wed, 12 Oct 2022 11:03:28 -0700 (PDT)
X-ASG-Debug-ID: 1665597806-18471ce6bd117e80001-ziuLRu
Received: from atlas.zonit.com ([199.88.250.66]) by antispam1.zonit.com with ESMTP id 3jcp9qhdrCPx59pH for <linux-scsi@vger.kernel.org>; Wed, 12 Oct 2022 12:03:26 -0600 (MDT)
X-Barracuda-Envelope-From: toms@zonit.com
X-Barracuda-Effective-Source-IP: UNKNOWN[199.88.250.66]
X-Barracuda-Apparent-Source-IP: 199.88.250.66
Received: from [172.30.2.121] (unknown [172.30.2.121])
        by atlas.zonit.com (Postfix) with ESMTP id E88973A3763
        for <linux-scsi@vger.kernel.org>; Wed, 12 Oct 2022 12:03:25 -0600 (MDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 atlas.zonit.com E88973A3763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zonit.com; s=atlas;
        t=1665597806; bh=LQWLFxKTK96WRH07hUtwD8oF4+uoCYDjCGhba1yJ+0k=;
        h=Date:From:Subject:To:From;
        b=pFRgvYdHq0Z7/99JCHED+XGGWy5iwdRXZbhDSY7UgBwDJr3S6Sb+jmZSjs+9WCK2e
         qDDg8I1wy7KBIuZSvby3cFUGIF7NtwPC1r6yIgqVz2gRX2UA28xqr2A0XaIrdRqXTC
         PyMHhj/ttLFpH+9tDdHmo+TP53d+dR10fb2QAjoM=
Message-ID: <bfee9015-d12d-89d4-d278-439baae3293b@zonit.com>
Date:   Wed, 12 Oct 2022 12:03:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Tom Spettigue <toms@zonit.com>
Subject: Errors with Sun StorageTek STK RAID INT (Adaptec ASR-5805) with EL
 8.6 driver?
To:     linux-scsi@vger.kernel.org
X-ASG-Orig-Subj: Errors with Sun StorageTek STK RAID INT (Adaptec ASR-5805) with EL
 8.6 driver?
Content-Language: en-US
Autocrypt: addr=toms@zonit.com; keydata=
 xsBNBF89qnoBCADGzTB5IUOH/6fz5DIm4FTIMN6ATEYcTMMU65TAERjkFCC1EXxfRew9h9sp
 Ay6/4bwrg8atjmY6PRDZrF8nXs5wibZNwsORSO6ppqdNqEQT+mkl1tEc7mmShz1MRpHvCWJq
 2YyzdWG153dwr6ER1GH496EeroaDDi1pnFTAHp0gH4Lvo75zMkVfbf92CdMyIvw295YqS0XV
 fB2N025Wa38SBxoP4YqRpD1CuhYeIxlj0PJ844CSTdFVk48YkGd/kpW/L9E3Xl7WxrnXz6/2
 Q8YZbg99RX2j4IWDtVyArprtHilQfUe7w1kl+SFsR8FPeS9ayH2uEDF/lVJv7xaRJXWPABEB
 AAHNHlRvbSBTcGV0dGlndWUgPHRvbXNAem9uaXQuY29tPsLAlAQTAQgAPhYhBEvM5cdoINL1
 Q+Z45vg4tbRdeUsmBQJhICcTAhsDBQkFl7SYBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJ
 EPg4tbRdeUsmadsIAIoRGucz9ZAWt4U3SCR/ZeqpuGRQtz+/h+5Jj+B5t5Bx8uNarYUOy7va
 qKZjE2h3XRznwE6toHJksTCa9I7gwyfbH7I/Fp65A05OTA8HOaI6ZOvVq0MksRZox9w/7iV4
 BMupydzX6br/vNj+a2kgHWCykvos22eMfzeMohnsYMmKkCvo8KTIMjwOwknrWQdsTbZ3kR5h
 CN56kWfdjeM1Nr8GrOn72YQy5Ydchn2agJG3QXQJmBrBLnquaxuOEhC9iHPLjBMgdRrb5BIV
 WyorPd3fCyJW/68wqondZtL5Cuhl7ZDsV4FDSu7eBVjMstqtAUKOMuB8ny6KlCSGi2qyNgrO
 wE0EXz2qegEIAKugsXYAB3+GbcBSlfTvdUZMulO8t+zb/pKE6xhsRQof8JvcN4YCwhYe9Oal
 RiucQjBaf6wBld0sg+j5CpCbRnU3Ph54f4QEWme3gb0yJ23yxRHU3kwDg7LZvQbtbZ02GzcZ
 7TykolBkHV79sU+cxPXkjMtStni+ZdIwVRphlPQZ+DCPJK9f7x9fjF5CqpGeXCyv+SySNOkV
 3/i9NRP/ya1JovPw+hdwLj05D9+ktDfzNxJzYAFs4md73SnzjB7hMNU/SuuB9iXi9cZjx03T
 VITD4M7yMRkaPV1/LuZazNgDpuJcsbCOeurEMVOipm+ft4Hc3lPZrBEjNkOA0ToLAiMAEQEA
 AcLAhgQYAQgAJhYhBEvM5cdoINL1Q+Z45vg4tbRdeUsmBQJhICcTAhsMBQkFl7SYABQJEPg4
 tbRdeUsmCRD4OLW0XXlLJowGB/4/lEgxjDNYyz/E9n3jKW/ppNmrE+7DZjWf+HwIIwot1C9/
 tU8+3Npydeq9jSq8nV2ByPZhjet/+Iw6vO+iGZH6Mqw9XBqLh5YZ/MvGOEhFagNfwDyBohpc
 Amo0A7j4mzLSdYCCzS4ihPqfiLua2zk3t7yQ4UbGxt710WpffREHNwp1SkkNomKnSIfvCScp
 IWmHAZ9PiOlw+unK6vZIWBqR4JVYNRknxtCjLGkgdR4FPOI+UmKfxqyXx6+J6aSMtJnNotQq
 cFSJCMOu7hqCVIbzAtzq5pelSQ67vNTBMA20udYyKf2AcG3Xz1HV7vbwoCcNIpMUsuHA+lod
 4Pt6IX7N
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wb0SoypQBXSQzq9DRIAWiAh1"
X-Barracuda-Connect: UNKNOWN[199.88.250.66]
X-Barracuda-Start-Time: 1665597806
X-Barracuda-URL: https://antispam1.zonit.com:443/cgi-mod/mark.cgi
X-ASG-Orig-Subj: Errors with Sun StorageTek STK RAID INT (Adaptec ASR-5805) with EL
 8.6 driver?
X-Virus-Scanned: by bsmtpd at zonit.com
X-Barracuda-Scan-Msg-Size: 1823
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101371
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wb0SoypQBXSQzq9DRIAWiAh1
Content-Type: multipart/mixed; boundary="------------0wDQ0alFyf1BqsCmOKezOjXD";
 protected-headers="v1"
From: Tom Spettigue <toms@zonit.com>
To: linux-scsi@vger.kernel.org
Message-ID: <bfee9015-d12d-89d4-d278-439baae3293b@zonit.com>
Subject: Errors with Sun StorageTek STK RAID INT (Adaptec ASR-5805) with EL
 8.6 driver?

--------------0wDQ0alFyf1BqsCmOKezOjXD
Content-Type: multipart/mixed; boundary="------------uYEmIg1mXe4M8yb3NcuaGL5o"

--------------uYEmIg1mXe4M8yb3NcuaGL5o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGV5IGFsbCAtDQoNCldlIGhhdmUgYW4gb2xkZXIgU3VuIE1pY3Jvc3lzdGVtcyBTdW5GaXJl
IHg0MjUwIHNlcnZlciB3aXRoIG9uZSBvZiBTdW4ncyANClNUSyBSQUlEIElOVCwgYSByZWJh
ZGdlZCBBZGFwdGVjIEFTUi01ODA1IChDb3VnYXIpIFJBSUQgSEJBIHRoYXQgdGFrZXMgDQp0
aGUgYWFjcmFpZCBkcml2ZXIsIGFuZCBJJ20gZ2V0dGluZyBhbGwga2luZHMgb2YgZXJyb3Jz
IHdpdGggaXQgaW4gQWxtYSANCkxpbnV4IDguNi4gSSBoYXZlIHBlcmZvcm1lZCBoYXJkd2Fy
ZSB0ZXN0cyBvZiBib3RoIHRoZSBzZXJ2ZXIncyBtZW1vcnkgDQooaXQgcGFzc2VkIGEgd2Vl
a2VuZCBvZiBtZW10ZXN0ODYrIHJ1bnMgb2YgMjQgcGFzc2VzKSBhcyB3ZWxsIGFzIGFsbCAx
NiANCm9mIG91ciBTdW4tYnJhbmRlZCBIR1NUIDkwMCBHQiAxMGsgUlBNIFNBUyBkcml2ZXMg
KHVzaW5nIFNlYWdhdGUncyANClNlYVRvb2xzIEJvb3RhYmxlLCBhbGwgMTYgcGFzc2VkIFMu
TS5BLlIuVC4gY2hlY2tzIGFzIHdlbGwgYXMgc2hvcnQgYW5kIA0KbG9uZyBkcml2ZSBzZWxm
LXRlc3RzKSwgYW5kIGFsbCBwYXNzIHdpdGggZmx5aW5nIGNvbG9ycyBhY3Jvc3MgbXVsdGlw
bGUgDQpydW5zIG9mIGV2ZXJ5IHRlc3QuDQoNCkkgbm9uZXRoZWxlc3MgYW0gZ2V0dGluZyBh
bGwga2luZHMgb2YgZXJyb3JzIG9uIG15IEFsbWEgTGludXggOC42IA0KaW5zdGFsbCB3aXRo
IHRoYXQgZGQtYWFjcmFpZC0xLjIuMS03LmVsOF82LmVscmVwby5pc28gZHJpdmVyIG9idGFp
bmVkIA0KZnJvbSBodHRwczovL2VscmVwby5vcmcvbGludXgvZHVkL2VsOC94ODZfNjQvLiBJ
IGRvbid0IGtub3cgaWYgdGhhdCdzIA0KdGhlIHdyb25nIGRyaXZlciBvciB3aGF0LCBidXQg
SSBnZXQgYmFzaWNhbGx5IG9uZSBzZXNzaW9uIG9mIHVzYWJsZSANCkxpbnV4LCBhbmQgb25j
ZSBJIHJlYm9vdCwgSSBnZXQgYWxsIGtpbmRzIG9mIGVycm9ycyAtIHNlZSBoZXJlOg0KDQpo
dHRwczovL2ltZ3VyLmNvbS9hL3F0MmFudzMNCg0KL2Rldi9zZGEgaXMgYSBzaW1wbGUsIHR3
by1kcml2ZSBSQUlELTEgYXJyYXkgLSBhbmQgSSBoYXZlIHRlc3RlZCBub3cgDQpmb3VyIGRp
ZmZlcmVudCBkcml2ZXMgaW4gdGhhdCBhcnJheSBpbiB2YXJ5aW5nIGNvbWJpbmF0aW9ucywg
YW5kIEkgZ2V0IA0KdGhlc2UgZXJyb3JzIGluIGFsbCBvZiB0aGVtLiBJIGV2ZW4gc3dhcHBl
ZCBvdXQgb3VyIFN1biBTVEsgUkFJRCBJTlQgDQooQ291Z2FyKSBSQUlEIEhCQSBmb3IgYW5v
dGhlciBvbmUgb2YgdGhlIHNhbWUgbWFrZS9tb2RlbCwgYW5kIGdvdCB0aGUgDQpzYW1lIGVy
cm9ycy4gTmVpdGhlciB0aGUgQWRhcHRlYyBSQUlEIEJJT1MgcmVwb3J0cyBhbnkgcHJvYmxl
bXMgd2l0aCB0aGUgDQphcnJheXMsIG5vciBkb2VzIFNlYVRvb2xzIC0gc28gSSdtIGluY3Jl
YXNpbmdseSBkaXNpbmNsaW5lZCB0byBiZWxpZXZlIA0KdGhhdCBhbnkgb2Ygb3VyIGRyaXZl
cyBhcmUgYmFkLCBJJ20gc3RhcnRpbmcgdG8gdGhpbmsgdGhpcyBpcyBzb21lIGtpbmQgDQpv
ZiBjb25maWd1cmF0aW9uIHByb2JsZW0sIG9yIHNvbWUga2luZCBvZiBkcml2ZXIgcHJvYmxl
bSB3aXRoIHRoZSANCmRkLWFhY3JhaWQtMS4yLjEtNy5lbDhfNi5lbHJlcG8uaXNvIGFhY3Jh
aWQgZHJpdmVyIHRoYXQgSSdtIHVzaW5nLiA6UA0KDQpBbnkgaWRlYXM/DQoNCi0tIA0KVG9t
IFNwZXR0aWd1ZQ0KU3RhZmYgRW5naW5lZXINCig3MjApIDQwNi01MjY5DQpab25pdCBTdHJ1
Y3R1cmVkIFNvbHV0aW9ucw0Kd3d3Lnpvbml0LmNvbQ0KDQo=
--------------uYEmIg1mXe4M8yb3NcuaGL5o
Content-Type: application/pgp-keys; name="OpenPGP_0xF838B5B45D794B26.asc"
Content-Disposition: attachment; filename="OpenPGP_0xF838B5B45D794B26.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBF89qnoBCADGzTB5IUOH/6fz5DIm4FTIMN6ATEYcTMMU65TAERjkFCC1EXxf
Rew9h9spAy6/4bwrg8atjmY6PRDZrF8nXs5wibZNwsORSO6ppqdNqEQT+mkl1tEc
7mmShz1MRpHvCWJq2YyzdWG153dwr6ER1GH496EeroaDDi1pnFTAHp0gH4Lvo75z
MkVfbf92CdMyIvw295YqS0XVfB2N025Wa38SBxoP4YqRpD1CuhYeIxlj0PJ844CS
TdFVk48YkGd/kpW/L9E3Xl7WxrnXz6/2Q8YZbg99RX2j4IWDtVyArprtHilQfUe7
w1kl+SFsR8FPeS9ayH2uEDF/lVJv7xaRJXWPABEBAAHNHlRvbSBTcGV0dGlndWUg
PHRvbXNAem9uaXQuY29tPsLAlAQTAQgAPhYhBEvM5cdoINL1Q+Z45vg4tbRdeUsm
BQJhICcTAhsDBQkFl7SYBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEPg4tbRd
eUsmadsIAIoRGucz9ZAWt4U3SCR/ZeqpuGRQtz+/h+5Jj+B5t5Bx8uNarYUOy7va
qKZjE2h3XRznwE6toHJksTCa9I7gwyfbH7I/Fp65A05OTA8HOaI6ZOvVq0MksRZo
x9w/7iV4BMupydzX6br/vNj+a2kgHWCykvos22eMfzeMohnsYMmKkCvo8KTIMjwO
wknrWQdsTbZ3kR5hCN56kWfdjeM1Nr8GrOn72YQy5Ydchn2agJG3QXQJmBrBLnqu
axuOEhC9iHPLjBMgdRrb5BIVWyorPd3fCyJW/68wqondZtL5Cuhl7ZDsV4FDSu7e
BVjMstqtAUKOMuB8ny6KlCSGi2qyNgrOwE0EXz2qegEIAKugsXYAB3+GbcBSlfTv
dUZMulO8t+zb/pKE6xhsRQof8JvcN4YCwhYe9OalRiucQjBaf6wBld0sg+j5CpCb
RnU3Ph54f4QEWme3gb0yJ23yxRHU3kwDg7LZvQbtbZ02GzcZ7TykolBkHV79sU+c
xPXkjMtStni+ZdIwVRphlPQZ+DCPJK9f7x9fjF5CqpGeXCyv+SySNOkV3/i9NRP/
ya1JovPw+hdwLj05D9+ktDfzNxJzYAFs4md73SnzjB7hMNU/SuuB9iXi9cZjx03T
VITD4M7yMRkaPV1/LuZazNgDpuJcsbCOeurEMVOipm+ft4Hc3lPZrBEjNkOA0ToL
AiMAEQEAAcLAhgQYAQgAJhYhBEvM5cdoINL1Q+Z45vg4tbRdeUsmBQJhICcTAhsM
BQkFl7SYABQJEPg4tbRdeUsmCRD4OLW0XXlLJowGB/4/lEgxjDNYyz/E9n3jKW/p
pNmrE+7DZjWf+HwIIwot1C9/tU8+3Npydeq9jSq8nV2ByPZhjet/+Iw6vO+iGZH6
Mqw9XBqLh5YZ/MvGOEhFagNfwDyBohpcAmo0A7j4mzLSdYCCzS4ihPqfiLua2zk3
t7yQ4UbGxt710WpffREHNwp1SkkNomKnSIfvCScpIWmHAZ9PiOlw+unK6vZIWBqR
4JVYNRknxtCjLGkgdR4FPOI+UmKfxqyXx6+J6aSMtJnNotQqcFSJCMOu7hqCVIbz
Atzq5pelSQ67vNTBMA20udYyKf2AcG3Xz1HV7vbwoCcNIpMUsuHA+lod4Pt6IX7N
=3D6IFn
-----END PGP PUBLIC KEY BLOCK-----



--------------uYEmIg1mXe4M8yb3NcuaGL5o--

--------------0wDQ0alFyf1BqsCmOKezOjXD--

--------------wb0SoypQBXSQzq9DRIAWiAh1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEES8zlx2gg0vVD5njm+Di1tF15SyYFAmNHAW0FAwAAAAAACgkQ+Di1tF15SyaY
fgf/QhcW3ldlEjuxGkTyO0CbtyJpA1+gGpixhoSB2DdxE3ED2W7FUmEGf8PgvM25u36ORpZ8ZqAM
ScovJ64QkRSVkovRdnnVyN/SCTWBrH2np2MkoKKqh4wvjWI/u59Wb3WONNxE+tPuAHi4qdfqcit1
S+lemIOzrxd+H1YS+weKaN15cF+l0JDOYwiKHpU9LNzhjKVlNG13yvtFRugcPLF8UyChBnFObtjU
2Zj7QXTornovnvHjl1osDdhBR931R6WM3EP/AKSEEc5BcFYCWYZu134gBOKvarNuughH/VQupwiR
6n+4C5GBWqZ5/vhTceSxyyvfOeoqVydqftdwj/Nvvw==
=A7xx
-----END PGP SIGNATURE-----

--------------wb0SoypQBXSQzq9DRIAWiAh1--
