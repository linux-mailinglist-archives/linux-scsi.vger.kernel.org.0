Return-Path: <linux-scsi+bounces-6365-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC291B003
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2024 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E71C22B24
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2024 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198D19A29A;
	Thu, 27 Jun 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4fiFCwVv"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B060EC4
	for <linux-scsi@vger.kernel.org>; Thu, 27 Jun 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518438; cv=none; b=jjLCpJR+2XoC5cGm1dg7txaOEY60rz8Odww3mX97rwJU2vt3p7y3ZJHwFBQqXwRfLFZ8yOpqHmTUnH3T1SkbKX41J9mVeYofrXTWEPOxA/NdFteaCw8oCpclu7u8qT2a3D2JJ/nFLCXZm+cIx2iNiKQJHemJfYnXjuOjizck7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518438; c=relaxed/simple;
	bh=OzUnDbW2Ip7NyHgx9vapownVMX9ahCU+cLyKOblQawo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK34Ys/PbtUH5FeArpr2TzWwxgPaRxkmsW3E2zKaagYkOgdmKC7QFkOQK5ZmpxaoY0e/ChViMhA0iRiD8IWYBF1jPb3s/PIRi/Kvu1Nl0B8tKkO4WJIAHpM2KMjxT1hyTwS6qGjOiuidSQZiUj5jnjvW1LlJwCLxtbiWAnegzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4fiFCwVv; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W98ZC4pXczll9br;
	Thu, 27 Jun 2024 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719518426; x=1722110427; bh=H5nX+
	Fu52eYaDdMq/RElQVofF9VNH/yW0Kdtl+ikNmo=; b=4fiFCwVvNgZMU1d03e2pL
	df17Lw9vVoxV5oWaSTv0kXVeyvYZgdXacERAFlin+0IPtj40buFnpeO4SyZErmTj
	d7sQg4Du/NiZydvv8oyQjAz2zjKYwKnBFcVn39ukx4M43XOouy9JCyxdzVB07xxN
	idRHG4orKEJMsImDmOXX36L4fFV+Dn3T8C6/s1gfIITVYKi0dTf+4i4xtSI0EvZe
	R5uD/RHnPcfQtt6sAnIGJY07tsropxDSbI5ix29BxzDrVhIZxs2zP3eCGNZGMaVI
	UDLhks/QUlWV6ezBcwNn0egB8fix8o4Q+k1AKGZJkoRmHjZH6/6sUTPSK/ccmB9a
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JsFs3SftKrOK; Thu, 27 Jun 2024 20:00:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W98Yx3zB8zlgMVW;
	Thu, 27 Jun 2024 20:00:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Daejun Park <daejun7.park@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bean Huo <beanhuo@micron.com>,
	Minwoo Im <minwoo.im@samsung.com>,
	Maramaina Naresh <quic_mnaresh@quicinc.com>,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 2/7] scsi: ufs: Initialize struct uic_command once
Date: Thu, 27 Jun 2024 12:58:28 -0700
Message-ID: <20240627195918.2709502-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240627195918.2709502-1-bvanassche@acm.org>
References: <20240627195918.2709502-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of first zero-initializing struct uic_command and next initializi=
ng
it memberwise, initialize all members at once.

Reviewed-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 61 ++++++++++++++++++++-------------------
 include/ufs/ufshcd.h      |  4 +--
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1fc08e34aaf9..b7ceedba4f93 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3993,11 +3993,11 @@ static void ufshcd_host_memory_configure(struct u=
fs_hba *hba)
  */
 static int ufshcd_dme_link_startup(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D UIC_CMD_DME_LINK_STARTUP,
+	};
 	int ret;
=20
-	uic_cmd.command =3D UIC_CMD_DME_LINK_STARTUP;
-
 	ret =3D ufshcd_send_uic_cmd(hba, &uic_cmd);
 	if (ret)
 		dev_dbg(hba->dev,
@@ -4015,11 +4015,11 @@ static int ufshcd_dme_link_startup(struct ufs_hba=
 *hba)
  */
 static int ufshcd_dme_reset(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D UIC_CMD_DME_RESET,
+	};
 	int ret;
=20
-	uic_cmd.command =3D UIC_CMD_DME_RESET;
-
 	ret =3D ufshcd_send_uic_cmd(hba, &uic_cmd);
 	if (ret)
 		dev_err(hba->dev,
@@ -4054,11 +4054,11 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
  */
 static int ufshcd_dme_enable(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D UIC_CMD_DME_ENABLE,
+	};
 	int ret;
=20
-	uic_cmd.command =3D UIC_CMD_DME_ENABLE;
-
 	ret =3D ufshcd_send_uic_cmd(hba, &uic_cmd);
 	if (ret)
 		dev_err(hba->dev,
@@ -4111,7 +4111,12 @@ static inline void ufshcd_add_delay_before_dme_cmd=
(struct ufs_hba *hba)
 int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 			u8 attr_set, u32 mib_val, u8 peer)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D peer ? UIC_CMD_DME_PEER_SET : UIC_CMD_DME_SET,
+		.argument1 =3D attr_sel,
+		.argument2 =3D UIC_ARG_ATTR_TYPE(attr_set),
+		.argument3 =3D mib_val,
+	};
 	static const char *const action[] =3D {
 		"dme-set",
 		"dme-peer-set"
@@ -4120,12 +4125,6 @@ int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 a=
ttr_sel,
 	int ret;
 	int retries =3D UFS_UIC_COMMAND_RETRIES;
=20
-	uic_cmd.command =3D peer ?
-		UIC_CMD_DME_PEER_SET : UIC_CMD_DME_SET;
-	uic_cmd.argument1 =3D attr_sel;
-	uic_cmd.argument2 =3D UIC_ARG_ATTR_TYPE(attr_set);
-	uic_cmd.argument3 =3D mib_val;
-
 	do {
 		/* for peer attributes we retry upon failure */
 		ret =3D ufshcd_send_uic_cmd(hba, &uic_cmd);
@@ -4155,7 +4154,10 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_set_attr);
 int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			u32 *mib_val, u8 peer)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D peer ? UIC_CMD_DME_PEER_GET : UIC_CMD_DME_GET,
+		.argument1 =3D attr_sel,
+	};
 	static const char *const action[] =3D {
 		"dme-get",
 		"dme-peer-get"
@@ -4189,10 +4191,6 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 a=
ttr_sel,
 		}
 	}
=20
-	uic_cmd.command =3D peer ?
-		UIC_CMD_DME_PEER_GET : UIC_CMD_DME_GET;
-	uic_cmd.argument1 =3D attr_sel;
-
 	do {
 		/* for peer attributes we retry upon failure */
 		ret =3D ufshcd_send_uic_cmd(hba, &uic_cmd);
@@ -4325,7 +4323,11 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba=
, struct uic_command *cmd)
  */
 int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D UIC_CMD_DME_SET,
+		.argument1 =3D UIC_ARG_MIB(PA_PWRMODE),
+		.argument3 =3D mode,
+	};
 	int ret;
=20
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP) {
@@ -4338,9 +4340,6 @@ int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba,=
 u8 mode)
 		}
 	}
=20
-	uic_cmd.command =3D UIC_CMD_DME_SET;
-	uic_cmd.argument1 =3D UIC_ARG_MIB(PA_PWRMODE);
-	uic_cmd.argument3 =3D mode;
 	ufshcd_hold(hba);
 	ret =3D ufshcd_uic_pwr_ctrl(hba, &uic_cmd);
 	ufshcd_release(hba);
@@ -4381,13 +4380,14 @@ EXPORT_SYMBOL_GPL(ufshcd_link_recovery);
=20
 int ufshcd_uic_hibern8_enter(struct ufs_hba *hba)
 {
-	int ret;
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D UIC_CMD_DME_HIBER_ENTER,
+	};
 	ktime_t start =3D ktime_get();
+	int ret;
=20
 	ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_ENTER, PRE_CHANGE);
=20
-	uic_cmd.command =3D UIC_CMD_DME_HIBER_ENTER;
 	ret =3D ufshcd_uic_pwr_ctrl(hba, &uic_cmd);
 	trace_ufshcd_profile_hibern8(dev_name(hba->dev), "enter",
 			     ktime_to_us(ktime_sub(ktime_get(), start)), ret);
@@ -4405,13 +4405,14 @@ EXPORT_SYMBOL_GPL(ufshcd_uic_hibern8_enter);
=20
 int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd =3D {0};
+	struct uic_command uic_cmd =3D {
+		.command =3D UIC_CMD_DME_HIBER_EXIT,
+	};
 	int ret;
 	ktime_t start =3D ktime_get();
=20
 	ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_EXIT, PRE_CHANGE);
=20
-	uic_cmd.command =3D UIC_CMD_DME_HIBER_EXIT;
 	ret =3D ufshcd_uic_pwr_ctrl(hba, &uic_cmd);
 	trace_ufshcd_profile_hibern8(dev_name(hba->dev), "exit",
 			     ktime_to_us(ktime_sub(ktime_get(), start)), ret);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9e0581115b34..d4d63507d090 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -73,8 +73,8 @@ enum ufs_event_type {
  * @done: UIC command completion
  */
 struct uic_command {
-	u32 command;
-	u32 argument1;
+	const u32 command;
+	const u32 argument1;
 	u32 argument2;
 	u32 argument3;
 	int cmd_active;

