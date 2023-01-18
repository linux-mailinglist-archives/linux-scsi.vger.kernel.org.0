Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B99671193
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Jan 2023 04:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjARDNE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Jan 2023 22:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARDNC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Jan 2023 22:13:02 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6865450854
        for <linux-scsi@vger.kernel.org>; Tue, 17 Jan 2023 19:13:01 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id E48172F20231; Wed, 18 Jan 2023 03:12:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 634022F2022A;
        Wed, 18 Jan 2023 03:12:58 +0000 (UTC)
Date:   Wed, 18 Jan 2023 06:12:55 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Stephen M. Cameron" <scameron@beardog.cce.hp.com>,
        storagedev@microchip.com, Don Brace <don.brace@microchip.com>,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi: hpsa: fix allocation size for scsi_host_alloc()
Message-ID: <20230118031255.GE15213@altlinux.org>
References: <20230116133140.GB8107@altlinux.org>
 <39006233-ff6f-82ad-b772-e00e789375a5@acm.org>
 <20230117095644.GA12547@altlinux.org>
 <30d3e555-4fb0-23df-abeb-e1c3dc41543e@ispras.ru>
 <20230117211201.GD15213@altlinux.org>
 <531f3f82-712c-eb0b-d22d-710e8a36b3c2@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <531f3f82-712c-eb0b-d22d-710e8a36b3c2@acm.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-17 13:23:19 -0800, Bart Van Assche wrote:

 > My understanding is that you used an incorrect commit hash.
 > Hence, it is up to you to fix the commit hash.

ACK. Resending:


The 'h' is a pointer to struct ctlr_info, so it's just 4 or 8
bytes, while the structure itself is much bigger.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edd163687ea5 ("[SCSI] hpsa: combine hpsa_scsi_detect and hpsa_regist=
er_scsi")
Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 4dbf51e2623ad543..f6da34850af9dd46 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5850,7 +5850,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
=20
-	sh =3D scsi_host_alloc(&hpsa_driver_template, sizeof(h));
+	sh =3D scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
 	if (sh =3D=3D NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;


--=20
Alexey V. Vissarionov
gremlin =F0=F2=E9 altlinux =F4=FE=EB org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJjx2O3AAoJEFv2F9znRj5KifcQAIPegRUYNZHIPVqttQloAYBR
H5RKtJgwzyOaLmOa2jdRS+o8cFXkWnpAggJCpaMTrMEnTGNlC1dGSiDg1q7SxymB
6X6gcyVGNiWS58fq7xe86uzm/jq/6Osvy0IrbCE9AcfVPKwTgMlGx8FWN7C7qXCM
1MWY1w/Jo4HxegNdj+/jRwXF0QPQZ0scJD7MCoQRwX24f+DD/ojrBZeaH1I7uLrW
RQq5OR9XXnM7mFHs/RbtpclCNDs0vRTJ40tOemtLVc/CGdtu/49XedCgJa2ru4Dg
FHlqMkz4Rk8U5jWdryxuc6Rf6Gl9zv6XAenhzvdKNONS2Y3RRnZQWYtRj526z7fQ
p3M172L+0xuUPTntDX+DVyshOtHwDMa48d20aC/Vn+YzCFutDEZjYkfrB4iXiAw5
IR4opL16SrvU1/0UNWegf1V6wNvyoXHAHCtqiGYSmKS/tgXxHdBcG0BR5KDMOjYl
nwgf3G1tdlFbL2692TqywQcRslJd/jmFU+uAfNu57cwA/rdni4ly1NA5YKZ40wWI
WEnScHloOlH67E3qTo3GwcUC+l35+dp4UAi6FTRNO0KWNIBSQPR0KLSKvO7uuq2+
w9B+dYAAuwFJ071CUIv2rN34zXvGj7+HZoEyr38rSi6OmsY7uVoVzHf7gylkN8lt
rYDnO82bFV1OQke081NH
=eQcB
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
