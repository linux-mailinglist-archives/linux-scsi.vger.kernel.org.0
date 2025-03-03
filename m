Return-Path: <linux-scsi+bounces-12637-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7251A4EBD9
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Mar 2025 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13220170162
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Mar 2025 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294125D1F3;
	Tue,  4 Mar 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FzKs2yQ2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B9259CB0
	for <linux-scsi@vger.kernel.org>; Tue,  4 Mar 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112644; cv=pass; b=msqZTF40mQVBZKlHArr+XgEek5kB5sgtpjGYHu7luo8eYcmbKkZqoAdWvgUfHgGp2h7KecwfjXYuQjER8i4elBTWSFjJP8zFHTP9N5HDWaCWAYtpFbAGqAiJF08xl3yyMNg3hjrPXobEZuLTwgRFQqhsvXuyfXpZq6KiHlSffMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112644; c=relaxed/simple;
	bh=HOisNs9xmhTkNfqIGQ85WEO/hhfcVzqEXsxq1Zf3/jU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tX9zgbw6RlFH1wiYYgWh3BvGTs2LpgCze2qpqDs8ZivuX5xg8OSHbq7RDubRnyR+mUVsdUDbtdLQdfatfesyR6K8OI2XjQsMATIGY22snM92iA13Z987qJ6infxBt2Y4mu8nNzVgfvWMqijuq7VurgUkiUDjjJnH6IlE//KeEZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FzKs2yQ2; arc=none smtp.client-ip=212.227.15.14; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 439DC40CECAC
	for <linux-scsi@vger.kernel.org>; Tue,  4 Mar 2025 21:24:01 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fW26vjfzG07q
	for <linux-scsi@vger.kernel.org>; Tue,  4 Mar 2025 18:19:58 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id A2FDE4272A; Tue,  4 Mar 2025 18:19:46 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FzKs2yQ2
X-Envelope-From: <linux-kernel+bounces-541246-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FzKs2yQ2
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 67001425EB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:12:26 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id F139B2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:12:25 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC743AEA98
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2491F0E2B;
	Mon,  3 Mar 2025 09:11:38 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A871F03E1;
	Mon,  3 Mar 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993095; cv=none; b=e+CqhUC2scqwLZvfQ99gbB9gsvpBt/+3+1VzA8gzXs6oXBYDejgi8qKIDDx3LssE9pFJ5wdrtLNYbT0qjvQyFiWs+8YbfHVjekoADCJjTEV/oAcor1bXFPJ3xY1BhXsem8PIuvbGMz/gnp6ueabl9MUPUCRtIpgqjxtN4bi63RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993095; c=relaxed/simple;
	bh=HOisNs9xmhTkNfqIGQ85WEO/hhfcVzqEXsxq1Zf3/jU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZKk9iQgkc4sKjhi+pqKyJrkb5lcquUmF3AirJ8XMjYqC3b0WXI/Jaj7qvSZvQRtXgomTxxpPXfi579c0zd5RmXuthMHDcPTxQvn/MDUYteqr12Vxyoht6U0jC5wVir9mptU4aqRuX8WmviJHCMsFCQLFJJ3yb633NarpG2Jc2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FzKs2yQ2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740993085; x=1741597885; i=markus.elfring@web.de;
	bh=WARxepTLbX6z7UXlbBldqqIu0yYUulxOMgywu3vUm8Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FzKs2yQ2+Dr9AkXJ6s8AUs3iApm0Qd3ZZqIUDNbtjxegwkj/Z7WgngqpRAhVEP1q
	 E1MbzsmRG8HLcN8bx0DZAab+LWs5uKlToUU0P/paYopVSjO1c0jJSuWwEqEqeEQaC
	 mGXvm4a3Etq/uDv5Fdi8oWom3vPUGfjWWtx82fa+YMZUkIuuyz4DQoPDVrL8Z7jrn
	 k0NIueOlYgbqNp1f15ZdnRuzdhdgJAGGBJHF7qvOxGumeRz5sUF1J/33dSZaCPBkb
	 P3AhDZcjb8pA2PIQXcPK/RAlZ4BOP9+uXCGgb5DHVC+xjrc0iGMMwx50XDMREXGzI
	 JP+3ZMh5yOhu15l45Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Igl-1t1rWE0UMB-00s8VH; Mon, 03
 Mar 2025 10:11:25 +0100
Message-ID: <35fbbb42-ec9d-4733-b3d6-8584b2faf6a1@web.de>
Date: Mon, 3 Mar 2025 10:11:24 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] scsi: hpsa: Move two variable assignments behind
 condition checks in hpsa_scsi_ioaccel_raid_map()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, Don Brace <don.brace@microchip.com>,
 "James E. J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joe Handzik <joseph.t.handzik@hp.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matt Gates <matthew.gates@hp.com>, Mike Miller
 <michael.miller@canonical.com>, Scott Teel <scott.teel@hp.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <fffd36dd-ec5d-4678-9e63-c52b0a711e76@web.de>
Content-Language: en-GB
In-Reply-To: <fffd36dd-ec5d-4678-9e63-c52b0a711e76@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bzWCP865hxjJTEzdBaGK2iRcc7VEhSNq1cYPXvWjRlHm0BJdnLy
 eNlUX2yPhreB/Y/Te31acndeYA/aUJapPjh00mR5T4j/2TGoNjeUt0+HCA+g35t9iSE9AGB
 5OSlbyFze3cHC6D/DMA+WTUTP9lJpe1Fc166mSGQ3ceC+qLQ0J7aSQJAFn2OemjuGMNKxC8
 wIug4eEhPB19n7y8/VuIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d6HGg8ekmF0=;myk+a3gQ/3PlLho3pKO1Ayta7eU
 8aeyv8FOEjEdidQ1NAMCRKImjLV0xvT0+JPW0Cm4cLrxoOw7VAj7nTKWtKn8gWf3AxDokG081
 atokRK2aySYq2+ek4cv6OLtBNGJLyWkAjCUbTrRSh9Po9bqjyvAGm+iYvtfRO7FcrQzFYP+4s
 QragXsZNdnMtFpNbu6fWwtnQdg35AS28/14KWa2PEfhPQ2ztiXQg6a0NpnEeuTKgwjhJpH+Ei
 5KUCDNISWIePjMDhNJtlX9DyG+scXkTSLdF9wOc4fFZoF7o6GsOVYjPWV4fM41i9Ry6zmL2nd
 5cuE9imOnZHDbR2OSaZsdZBMok6WG96pm9T17ZNTCa3ieSxM/c5dz4KaQVQfelYkyH03ejqJq
 IENXnwFUXnG9e6DcQA1ZzJYabLxkX35O9nTKDRBxMpORmWGN68SQKVicCZ9SKVwbdNHPjM17f
 c1qg+5y2mbH3OHZABpJG7+sRiiDOSwujIXYKe+BrbxB5O+zQEvJzgzkMTffFhB01KV2ZXOA0D
 fHUmYupX0Pa/7bHZmfAg7Yx4OquYIF/7P9+Omr7zDNnUgLxdTLXy/6kE19wYaSuwHoaLRAFNP
 2c53lfxy7EbFCZ9PIHA7cI7r/tW+RO/1uwheEYjooq72xxxi0yYxCmBHW68wzt3MoHfBnkfZA
 ai9NpgQbH7H2DpvDRICQ+mr1sXrwj8brk/IVA1qYtfGwqrJ8oKCrLx/VxuuwjZedaK0PEIOXL
 6JF9JCn6DFwzjWaKhDGO+ifvmDFw0r5A1V87Tc3tHqYUrucivTDknCgJyJaCeYrq9p+acGyoT
 NN7/NUT0yfTxcPiHbBzVm6biSsw3u4zjOyGbId9JBC9znc3F6AQCkwz9DF31oIa1Dzd/QVhzC
 ywqmPuPoPEBraRAwT8n2MdtIPohrIKmozTeuMkL2tkl7zwI6MpHebIAH+ESRDiXuLVGCF5Y8N
 goSNL8NFKVL3yOQhzwT88LPVbcyKrEyFxa4MYSZYC33mU/bOCO6Kgbw1GjMjUm6hWaOjoHMKg
 aOThhuZ6R6krfZP6Nfn2KhulCi0zv8dRZMpRYjKVas0rVXfDu9ugb+PggYZ0NjYgMLahHjGMu
 4x6WToLTBcxSTxeCkoiPnozGzN9g+QypkqiNqR4WT+CQNxxji7dhYnLi7ctKwl6gHdjsNGXij
 X1fAL0nELfsfMyJxFYw59Q8CR1sB/jfRnJ/3uykDsK8Zw4m+1NrFXpwmrEHKXpekNjuOobvIk
 Of69kDom93Fiek1PYFjK975PfYKZIGWfcxh1LQ9SpXXnOHxeBmU1oNElGqm+tSQRjzAAEM8ns
 sef7+/NcuLjsi+R7h1V+e8a84NHDAvdQF0bpLX5mud2pDW/+clmarQ0F7QUtuyoRXNrqLrOoX
 M3URhkyF16uuf1EMRLAWuiS+3OjF3NttBKD22p7aFMloZYrG/DEjZ718DnKpFqUzloXL0+MGX
 P09d/eQ==
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fW26vjfzG07q
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717323.02041@4WcNvTocGW71QPrLUUypcQ
X-ITU-MailScanner-SpamCheck: not spam

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 14 Apr 2023 11:00:40 +0200

Addresses of two data structure members were determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Chpsa_scsi_ioaccel_raid_map=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for two local variables behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 283b4a9b98b1 ("[SCSI] hpsa: add ioaccell mode 1 RAID offload suppor=
t.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/hpsa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..562bb5eab134 100644
=2D-- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5104,8 +5104,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 {
 	struct scsi_cmnd *cmd =3D c->scsi_cmd;
 	struct hpsa_scsi_dev_t *dev =3D cmd->device->hostdata;
-	struct raid_map_data *map =3D &dev->raid_map;
-	struct raid_map_disk_data *dd =3D &map->data[0];
+	struct raid_map_data *map;
+	struct raid_map_disk_data *dd;
 	int is_write =3D 0;
 	u32 map_index;
 	u64 first_block, last_block;
@@ -5209,6 +5209,8 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 	if (is_write && dev->raid_level !=3D 0)
 		return IO_ACCEL_INELIGIBLE;

+	map =3D &dev->raid_map;
+
 	/* check for invalid block or wraparound */
 	if (last_block >=3D le64_to_cpu(map->volume_blk_cnt) ||
 		last_block < first_block)
@@ -5397,6 +5399,7 @@ static int hpsa_scsi_ioaccel_raid_map(struct ctlr_in=
fo *h,
 	if (!c->phys_disk)
 		return IO_ACCEL_INELIGIBLE;

+	dd =3D &map->data[0];
 	disk_handle =3D dd[map_index].ioaccel_handle;
 	disk_block =3D le64_to_cpu(map->disk_starting_blk) +
 			first_row * le16_to_cpu(map->strip_size) +
=2D-
2.40.0




