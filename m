Return-Path: <linux-scsi+bounces-8584-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697E98AE53
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Sep 2024 22:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52381C2134A
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Sep 2024 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0161A2623;
	Mon, 30 Sep 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZuwKbJqt"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436D1A0BCF
	for <linux-scsi@vger.kernel.org>; Mon, 30 Sep 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727978; cv=none; b=bmHLKoCtrdOFNZZq+0GAy/pT5V8j2aNgcPGDxXGgJwqpdJX+T4LnL5Y1Oz07CysboLnk+CpSnuaGTxxAusIYpkQ8NGf15MRkXSYbpyPWRMZmCHGz6T06RTZSlfo+FdZU99dk+Nm3yHGFAkDl7dv5joL6vKFEdViHM157D9PeOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727978; c=relaxed/simple;
	bh=LOPEwz/PXLQo9eEH2EYLt3DzVrUqyuL06rBZh/PQv/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poVyH06w2S9mni2WgLgTUhV8xoA/IDEHYj85s/PbK5XptXWRZhF8fOlnYdpNv12CsyVc9UItQHusktGodnAQBZtPyR15usYFwXw2jnVfR6H0v7DY1k3/UuGqJZH2ozLgAbjuuH2Xxs5LksxLUcznzvE46q5EOwRbiyd0gK/XSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZuwKbJqt; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XHXdy712kz6ClY9b;
	Mon, 30 Sep 2024 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727727714; x=1730319715; bh=cSKT8
	1SG7oWWazsMtzU4ZzQs8CIDx3xttTwzjeIn+60=; b=ZuwKbJqtfR/yrW9Ma5IG3
	fXo4RRNnsMpBU99NYCW2wRf/myYVhuQvqKOvzOJEk9rm362mcs+LCbsNWFb3iu2D
	CntNWRXyrh9KxunHrf5mutyQTG0hGp2lCbBzaf71KkudZnRSEAYwVKDpOhD0CfFY
	JX0vzhpPn2RKTKxlwJ7MEa3u0FP8ck0VH8CPrOrAqFD2cPijvvi+E3EtIJad4Dxq
	wUFuOAPp0Gxbd3x7kFNaAGPRIvXbiTp5oI0L6iBw4C5wrtlwj5/BOuurtlX26XhM
	iU7fyfbdv7Y2HVRjELqL3fR6w4bbxlKq7a7y5E69AQvbhG4TE0sJry44NXc2+SJe
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id C6F8V_L4xy5R; Mon, 30 Sep 2024 20:21:54 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XHXWZ3lBlz6ClY9Y;
	Mon, 30 Sep 2024 20:20:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Steffen Maier <maier@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Adam Radford <aradford@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Khalid Aziz <khalid@gonehiking.org>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.com>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	Geoff Levand <geoff@infradead.org>,
	Nilesh Javali <njavali@marvell.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ching Huang <ching2048@areca.com.tw>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 2/4] scsi: Convert SCSI drivers to .device_configure()
Date: Mon, 30 Sep 2024 13:18:48 -0700
Message-ID: <20240930201937.2020129-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930201937.2020129-1-bvanassche@acm.org>
References: <20240930201937.2020129-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is agreement that the word "slave" should not be used in Linux
kernel source code. Hence this patch that converts all SCSI drivers from
.slave_configure() to .device_configure(). No functionality has been
changed.

Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c         |  5 +++--
 drivers/message/fusion/mptfc.c              |  2 +-
 drivers/message/fusion/mptsas.c             |  6 +++---
 drivers/message/fusion/mptscsih.c           |  4 ++--
 drivers/message/fusion/mptscsih.h           |  3 ++-
 drivers/message/fusion/mptspi.c             |  7 ++++---
 drivers/net/ethernet/allwinner/sun4i-emac.c |  4 ++--
 drivers/s390/scsi/zfcp_scsi.c               |  5 +++--
 drivers/scsi/3w-9xxx.c                      |  7 ++++---
 drivers/scsi/3w-sas.c                       |  7 ++++---
 drivers/scsi/3w-xxxx.c                      |  9 ++++----
 drivers/scsi/53c700.c                       |  7 ++++---
 drivers/scsi/BusLogic.c                     |  7 ++++---
 drivers/scsi/BusLogic.h                     |  3 ++-
 drivers/scsi/aacraid/linit.c                |  8 ++++---
 drivers/scsi/advansys.c                     | 23 +++++++++++----------
 drivers/scsi/aic7xxx/aic79xx_osm.c          |  4 ++--
 drivers/scsi/aic7xxx/aic7xxx_osm.c          |  4 ++--
 drivers/scsi/arcmsr/arcmsr_hba.c            |  8 ++++---
 drivers/scsi/bfa/bfad_im.c                  |  6 +++---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c           |  5 +++--
 drivers/scsi/csiostor/csio_scsi.c           |  6 +++---
 drivers/scsi/esp_scsi.c                     |  7 ++++---
 drivers/scsi/hpsa.c                         |  8 ++++---
 drivers/scsi/ibmvscsi/ibmvfc.c              |  7 ++++---
 drivers/scsi/ibmvscsi/ibmvscsi.c            |  8 ++++---
 drivers/scsi/ips.c                          |  6 +++---
 drivers/scsi/ips.h                          |  3 ++-
 drivers/scsi/lpfc/lpfc_scsi.c               | 21 ++++++++++++-------
 drivers/scsi/mvumi.c                        |  5 +++--
 drivers/scsi/myrb.c                         |  5 +++--
 drivers/scsi/myrs.c                         |  5 +++--
 drivers/scsi/ncr53c8xx.c                    |  5 +++--
 drivers/scsi/ps3rom.c                       |  5 +++--
 drivers/scsi/qedf/qedf_main.c               |  5 +++--
 drivers/scsi/qla1280.c                      |  6 +++---
 drivers/scsi/qla2xxx/qla_os.c               |  4 ++--
 drivers/scsi/qlogicpti.c                    |  5 +++--
 drivers/scsi/scsi_debug.c                   |  7 ++++---
 drivers/scsi/scsi_scan.c                    |  2 +-
 drivers/scsi/smartpqi/smartpqi_init.c       |  5 +++--
 drivers/scsi/snic/snic_main.c               |  6 +++---
 drivers/scsi/stex.c                         |  4 ++--
 drivers/scsi/storvsc_drv.c                  |  5 +++--
 drivers/scsi/sym53c8xx_2/sym_glue.c         |  5 +++--
 drivers/scsi/xen-scsifront.c                |  7 ++++---
 drivers/staging/rts5208/rtsx.c              |  4 ++--
 47 files changed, 166 insertions(+), 124 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp=
/srp/ib_srp.c
index 2916e77f589b..853130f9052f 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2844,7 +2844,8 @@ static int srp_target_alloc(struct scsi_target *sta=
rget)
 	return 0;
 }
=20
-static int srp_slave_configure(struct scsi_device *sdev)
+static int srp_device_configure(struct scsi_device *sdev,
+				struct queue_limits *lim)
 {
 	struct Scsi_Host *shost =3D sdev->host;
 	struct srp_target_port *target =3D host_to_target(shost);
@@ -3067,7 +3068,7 @@ static const struct scsi_host_template srp_template=
 =3D {
 	.name				=3D "InfiniBand SRP initiator",
 	.proc_name			=3D DRV_NAME,
 	.target_alloc			=3D srp_target_alloc,
-	.slave_configure		=3D srp_slave_configure,
+	.device_configure		=3D srp_device_configure,
 	.info				=3D srp_target_info,
 	.init_cmd_priv			=3D srp_init_cmd_priv,
 	.exit_cmd_priv			=3D srp_exit_cmd_priv,
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptf=
c.c
index 1b43fba24af1..b53a2ad26459 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -114,7 +114,7 @@ static const struct scsi_host_template mptfc_driver_t=
emplate =3D {
 	.queuecommand			=3D mptfc_qcmd,
 	.target_alloc			=3D mptfc_target_alloc,
 	.device_alloc			=3D mptfc_device_alloc,
-	.slave_configure		=3D mptscsih_slave_configure,
+	.device_configure		=3D mptscsih_device_configure,
 	.target_destroy			=3D mptfc_target_destroy,
 	.device_destroy			=3D mptscsih_device_destroy,
 	.change_queue_depth 		=3D mptscsih_change_queue_depth,
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpt=
sas.c
index 848c45d141e3..22d2debe617b 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1710,7 +1710,7 @@ mptsas_firmware_event_work(struct work_struct *work=
)
=20
=20
 static int
-mptsas_slave_configure(struct scsi_device *sdev)
+mptsas_device_configure(struct scsi_device *sdev, struct queue_limits *l=
im)
 {
 	struct Scsi_Host	*host =3D sdev->host;
 	MPT_SCSI_HOST	*hd =3D shost_priv(host);
@@ -1736,7 +1736,7 @@ mptsas_slave_configure(struct scsi_device *sdev)
 	mptsas_add_device_component_starget(ioc, scsi_target(sdev));
=20
  out:
-	return mptscsih_slave_configure(sdev);
+	return mptscsih_device_configure(sdev, lim);
 }
=20
 static int
@@ -2006,7 +2006,7 @@ static const struct scsi_host_template mptsas_drive=
r_template =3D {
 	.queuecommand			=3D mptsas_qcmd,
 	.target_alloc			=3D mptsas_target_alloc,
 	.device_alloc			=3D mptsas_device_alloc,
-	.slave_configure		=3D mptsas_slave_configure,
+	.device_configure		=3D mptsas_device_configure,
 	.target_destroy			=3D mptsas_target_destroy,
 	.device_destroy			=3D mptscsih_device_destroy,
 	.change_queue_depth 		=3D mptscsih_change_queue_depth,
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/m=
ptscsih.c
index 18664bbe8db5..cd7fd178413a 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -2399,7 +2399,7 @@ mptscsih_change_queue_depth(struct scsi_device *sde=
v, int qdepth)
  *	Return non-zero if fails.
  */
 int
-mptscsih_slave_configure(struct scsi_device *sdev)
+mptscsih_device_configure(struct scsi_device *sdev, struct queue_limits =
*lim)
 {
 	struct Scsi_Host	*sh =3D sdev->host;
 	VirtTarget		*vtarget;
@@ -3303,7 +3303,7 @@ EXPORT_SYMBOL(mptscsih_show_info);
 EXPORT_SYMBOL(mptscsih_info);
 EXPORT_SYMBOL(mptscsih_qcmd);
 EXPORT_SYMBOL(mptscsih_device_destroy);
-EXPORT_SYMBOL(mptscsih_slave_configure);
+EXPORT_SYMBOL(mptscsih_device_configure);
 EXPORT_SYMBOL(mptscsih_abort);
 EXPORT_SYMBOL(mptscsih_dev_reset);
 EXPORT_SYMBOL(mptscsih_target_reset);
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/m=
ptscsih.h
index e3b7368264d7..e4e014d17424 100644
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -117,7 +117,8 @@ extern int mptscsih_qcmd(struct scsi_cmnd *SCpnt);
 extern int mptscsih_IssueTaskMgmt(MPT_SCSI_HOST *hd, u8 type, u8 channel=
,
 	u8 id, u64 lun, int ctx2abort, ulong timeout);
 extern void mptscsih_device_destroy(struct scsi_device *device);
-extern int mptscsih_slave_configure(struct scsi_device *device);
+extern int mptscsih_device_configure(struct scsi_device *device,
+				     struct queue_limits *lim);
 extern int mptscsih_abort(struct scsi_cmnd * SCpnt);
 extern int mptscsih_dev_reset(struct scsi_cmnd * SCpnt);
 extern int mptscsih_target_reset(struct scsi_cmnd * SCpnt);
diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mpt=
spi.c
index 744487585a78..0bf33b5f7100 100644
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -746,7 +746,8 @@ static int mptspi_device_alloc(struct scsi_device *sd=
ev)
 	return 0;
 }
=20
-static int mptspi_slave_configure(struct scsi_device *sdev)
+static int mptspi_device_configure(struct scsi_device *sdev,
+				   struct queue_limits *lim)
 {
 	struct _MPT_SCSI_HOST *hd =3D shost_priv(sdev->host);
 	VirtTarget *vtarget =3D scsi_target(sdev)->hostdata;
@@ -754,7 +755,7 @@ static int mptspi_slave_configure(struct scsi_device =
*sdev)
=20
 	mptspi_initTarget(hd, vtarget, sdev);
=20
-	ret =3D mptscsih_slave_configure(sdev);
+	ret =3D mptscsih_device_configure(sdev, lim);
=20
 	if (ret)
 		return ret;
@@ -829,7 +830,7 @@ static const struct scsi_host_template mptspi_driver_=
template =3D {
 	.queuecommand			=3D mptspi_qcmd,
 	.target_alloc			=3D mptspi_target_alloc,
 	.device_alloc			=3D mptspi_device_alloc,
-	.slave_configure		=3D mptspi_slave_configure,
+	.device_configure		=3D mptspi_device_configure,
 	.target_destroy			=3D mptspi_target_destroy,
 	.device_destroy			=3D mptspi_device_destroy,
 	.change_queue_depth 		=3D mptscsih_change_queue_depth,
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/et=
hernet/allwinner/sun4i-emac.c
index d761c08fe5c1..511264cbf060 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -947,12 +947,12 @@ static int emac_configure_dma(struct emac_board_inf=
o *db)
 	if (err) {
 		netdev_err(ndev, "config dma slave failed\n");
 		err =3D -EINVAL;
-		goto out_slave_configure_err;
+		goto out_device_configure_err;
 	}
=20
 	return err;
=20
-out_slave_configure_err:
+out_device_configure_err:
 	dma_release_channel(db->rx_chan);
=20
 out_clear_chan:
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.=
c
index 355b99fa8c0f..58ccf8b967b9 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -49,7 +49,8 @@ static void zfcp_scsi_device_destroy(struct scsi_device=
 *sdev)
 	put_device(&zfcp_sdev->port->dev);
 }
=20
-static int zfcp_scsi_slave_configure(struct scsi_device *sdp)
+static int zfcp_scsi_device_configure(struct scsi_device *sdp,
+				      struct queue_limits *lim)
 {
 	if (sdp->tagged_supported)
 		scsi_change_queue_depth(sdp, default_depth);
@@ -428,7 +429,7 @@ static const struct scsi_host_template zfcp_scsi_host=
_template =3D {
 	.eh_target_reset_handler =3D zfcp_scsi_eh_target_reset_handler,
 	.eh_host_reset_handler	 =3D zfcp_scsi_eh_host_reset_handler,
 	.device_alloc		 =3D zfcp_scsi_device_alloc,
-	.slave_configure	 =3D zfcp_scsi_slave_configure,
+	.device_configure	 =3D zfcp_scsi_device_configure,
 	.device_destroy		 =3D zfcp_scsi_device_destroy,
 	.change_queue_depth	 =3D scsi_change_queue_depth,
 	.host_reset		 =3D zfcp_scsi_sysfs_host_reset,
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 6fb61c88ea11..3455c7bedacf 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1968,13 +1968,14 @@ static char *twa_string_lookup(twa_message_type *=
table, unsigned int code)
 } /* End twa_string_lookup() */
=20
 /* This function gets called when a disk is coming on-line */
-static int twa_slave_configure(struct scsi_device *sdev)
+static int twa_device_configure(struct scsi_device *sdev,
+				struct queue_limits *lim)
 {
 	/* Force 60 second timeout */
 	blk_queue_rq_timeout(sdev->request_queue, 60 * HZ);
=20
 	return 0;
-} /* End twa_slave_configure() */
+} /* End twa_device_configure() */
=20
 static const struct scsi_host_template driver_template =3D {
 	.module			=3D THIS_MODULE,
@@ -1984,7 +1985,7 @@ static const struct scsi_host_template driver_templ=
ate =3D {
 	.bios_param		=3D twa_scsi_biosparam,
 	.change_queue_depth	=3D scsi_change_queue_depth,
 	.can_queue		=3D TW_Q_LENGTH-2,
-	.slave_configure	=3D twa_slave_configure,
+	.device_configure	=3D twa_device_configure,
 	.this_id		=3D -1,
 	.sg_tablesize		=3D TW_APACHE_MAX_SGL_LENGTH,
 	.max_sectors		=3D TW_MAX_SECTORS,
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index caa6713a62a4..1731e3bd527d 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1523,13 +1523,14 @@ static void twl_shutdown(struct pci_dev *pdev)
 } /* End twl_shutdown() */
=20
 /* This function configures unit settings when a unit is coming on-line =
*/
-static int twl_slave_configure(struct scsi_device *sdev)
+static int twl_device_configure(struct scsi_device *sdev,
+				struct queue_limits *lim)
 {
 	/* Force 60 second timeout */
 	blk_queue_rq_timeout(sdev->request_queue, 60 * HZ);
=20
 	return 0;
-} /* End twl_slave_configure() */
+} /* End twl_device_configure() */
=20
 static const struct scsi_host_template driver_template =3D {
 	.module			=3D THIS_MODULE,
@@ -1539,7 +1540,7 @@ static const struct scsi_host_template driver_templ=
ate =3D {
 	.bios_param		=3D twl_scsi_biosparam,
 	.change_queue_depth	=3D scsi_change_queue_depth,
 	.can_queue		=3D TW_Q_LENGTH-2,
-	.slave_configure	=3D twl_slave_configure,
+	.device_configure	=3D twl_device_configure,
 	.this_id		=3D -1,
 	.sg_tablesize		=3D TW_LIBERATOR_MAX_SGL_LENGTH,
 	.max_sectors		=3D TW_MAX_SECTORS,
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 2c0fb6da0e60..b92d826bd158 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -172,7 +172,7 @@
                  Initialize queues correctly when loading with no valid =
units.
    1.02.00.034 - Fix tw_decode_bits() to handle multiple errors.
                  Add support for user configurable cmd_per_lun.
-                 Add support for sht->slave_configure().
+                 Add support for sht->device_configure().
    1.02.00.035 - Improve tw_allocate_memory() memory allocation.
                  Fix tw_chrdev_ioctl() to sleep correctly.
    1.02.00.036 - Increase character ioctl timeout to 60 seconds.
@@ -2221,13 +2221,14 @@ static void tw_shutdown(struct pci_dev *pdev)
 } /* End tw_shutdown() */
=20
 /* This function gets called when a disk is coming online */
-static int tw_slave_configure(struct scsi_device *sdev)
+static int tw_device_configure(struct scsi_device *sdev,
+			       struct queue_limits *lim)
 {
 	/* Force 60 second timeout */
 	blk_queue_rq_timeout(sdev->request_queue, 60 * HZ);
=20
 	return 0;
-} /* End tw_slave_configure() */
+} /* End tw_device_configure() */
=20
 static const struct scsi_host_template driver_template =3D {
 	.module			=3D THIS_MODULE,
@@ -2237,7 +2238,7 @@ static const struct scsi_host_template driver_templ=
ate =3D {
 	.bios_param		=3D tw_scsi_biosparam,
 	.change_queue_depth	=3D scsi_change_queue_depth,
 	.can_queue		=3D TW_Q_LENGTH-2,
-	.slave_configure	=3D tw_slave_configure,
+	.device_configure	=3D tw_device_configure,
 	.this_id		=3D -1,
 	.sg_tablesize		=3D TW_MAX_SGL_LENGTH,
 	.max_sectors		=3D TW_MAX_SECTORS,
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 5498417604fc..b2352a4a9266 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -159,7 +159,8 @@ STATIC int NCR_700_host_reset(struct scsi_cmnd * SCpn=
t);
 STATIC void NCR_700_chip_setup(struct Scsi_Host *host);
 STATIC void NCR_700_chip_reset(struct Scsi_Host *host);
 STATIC int NCR_700_device_alloc(struct scsi_device *SDpnt);
-STATIC int NCR_700_slave_configure(struct scsi_device *SDpnt);
+STATIC int NCR_700_device_configure(struct scsi_device *SDpnt,
+				    struct queue_limits *lim);
 STATIC void NCR_700_device_destroy(struct scsi_device *SDpnt);
 static int NCR_700_change_queue_depth(struct scsi_device *SDpnt, int dep=
th);
=20
@@ -330,7 +331,7 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	tpnt->can_queue =3D NCR_700_COMMAND_SLOTS_PER_HOST;
 	tpnt->sg_tablesize =3D NCR_700_SG_SEGMENTS;
 	tpnt->cmd_per_lun =3D NCR_700_CMD_PER_LUN;
-	tpnt->slave_configure =3D NCR_700_slave_configure;
+	tpnt->device_configure =3D NCR_700_device_configure;
 	tpnt->device_destroy =3D NCR_700_device_destroy;
 	tpnt->device_alloc =3D NCR_700_device_alloc;
 	tpnt->change_queue_depth =3D NCR_700_change_queue_depth;
@@ -2029,7 +2030,7 @@ NCR_700_device_alloc(struct scsi_device *SDp)
 }
=20
 STATIC int
-NCR_700_slave_configure(struct scsi_device *SDp)
+NCR_700_device_configure(struct scsi_device *SDp, struct queue_limits *l=
im)
 {
 	struct NCR_700_Host_Parameters *hostdata =3D=20
 		(struct NCR_700_Host_Parameters *)SDp->host->hostdata[0];
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 2135a2b3e2d0..88839c81db97 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2153,14 +2153,15 @@ static void __init blogic_inithoststruct(struct b=
logic_adapter *adapter,
 }
=20
 /*
-  blogic_slaveconfig will actually set the queue depth on individual
+  blogic_device_configure will actually set the queue depth on individua=
l
   scsi devices as they are permanently added to the device chain.  We
   shamelessly rip off the SelectQueueDepths code to make this work mostl=
y
   like it used to.  Since we don't get called once at the end of the sca=
n
   but instead get called for each device, we have to do things a bit
   differently.
 */
-static int blogic_slaveconfig(struct scsi_device *dev)
+static int blogic_device_configure(struct scsi_device *dev,
+				   struct queue_limits *lim)
 {
 	struct blogic_adapter *adapter =3D
 		(struct blogic_adapter *) dev->host->hostdata;
@@ -3672,7 +3673,7 @@ static const struct scsi_host_template blogic_templ=
ate =3D {
 	.name =3D "BusLogic",
 	.info =3D blogic_drvr_info,
 	.queuecommand =3D blogic_qcmd,
-	.slave_configure =3D blogic_slaveconfig,
+	.device_configure =3D blogic_device_configure,
 	.bios_param =3D blogic_diskparam,
 	.eh_host_reset_handler =3D blogic_hostreset,
 #if 0
diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index 7d1ec10f2430..1eb61e886ee3 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -1274,7 +1274,8 @@ static inline void blogic_incszbucket(unsigned int =
*cmdsz_buckets,
 static const char *blogic_drvr_info(struct Scsi_Host *);
 static int blogic_qcmd(struct Scsi_Host *h, struct scsi_cmnd *);
 static int blogic_diskparam(struct scsi_device *, struct block_device *,=
 sector_t, int *);
-static int blogic_slaveconfig(struct scsi_device *);
+static int blogic_device_configure(struct scsi_device *,
+				   struct queue_limits *lim);
 static void blogic_qcompleted_ccb(struct blogic_ccb *);
 static irqreturn_t blogic_inthandler(int, void *);
 static int blogic_resetadapter(struct blogic_adapter *, bool hard_reset)=
;
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 68f4dbcfff49..5de6b553400e 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -377,15 +377,17 @@ static int aac_biosparm(struct scsi_device *sdev, s=
truct block_device *bdev,
 }
=20
 /**
- *	aac_slave_configure		-	compute queue depths
+ *	aac_device_configure		-	compute queue depths
  *	@sdev:	SCSI device we are considering
+ *	@lim:	Request queue limits
  *
  *	Selects queue depths for each target device based on the host adapter=
's
  *	total capacity and the queue depth supported by the target device.
  *	A queue depth of one automatically disables tagged queueing.
  */
=20
-static int aac_slave_configure(struct scsi_device *sdev)
+static int aac_device_configure(struct scsi_device *sdev,
+				struct queue_limits *lim)
 {
 	struct aac_dev *aac =3D (struct aac_dev *)sdev->host->hostdata;
 	int chn, tid;
@@ -1487,7 +1489,7 @@ static const struct scsi_host_template aac_driver_t=
emplate =3D {
 	.queuecommand			=3D aac_queuecommand,
 	.bios_param			=3D aac_biosparm,
 	.shost_groups			=3D aac_host_groups,
-	.slave_configure		=3D aac_slave_configure,
+	.device_configure		=3D aac_device_configure,
 	.change_queue_depth		=3D aac_change_queue_depth,
 	.sdev_groups			=3D aac_dev_groups,
 	.eh_abort_handler		=3D aac_eh_abort,
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index fd4fcb37863d..9f4f4719021a 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -4496,7 +4496,7 @@ static int AdvInitAsc3550Driver(ADV_DVC_VAR *asc_dv=
c)
=20
 	/*
 	 * Microcode operating variables for WDTR, SDTR, and command tag
-	 * queuing will be set in slave_configure() based on what a
+	 * queuing will be set in device_configure() based on what a
 	 * device reports it is capable of in Inquiry byte 7.
 	 *
 	 * If SCSI Bus Resets have been disabled, then directly set
@@ -5013,7 +5013,7 @@ static int AdvInitAsc38C0800Driver(ADV_DVC_VAR *asc=
_dvc)
=20
 	/*
 	 * Microcode operating variables for WDTR, SDTR, and command tag
-	 * queuing will be set in slave_configure() based on what a
+	 * queuing will be set in device_configure() based on what a
 	 * device reports it is capable of in Inquiry byte 7.
 	 *
 	 * If SCSI Bus Resets have been disabled, then directly set
@@ -5508,7 +5508,7 @@ static int AdvInitAsc38C1600Driver(ADV_DVC_VAR *asc=
_dvc)
=20
 	/*
 	 * Microcode operating variables for WDTR, SDTR, and command tag
-	 * queuing will be set in slave_configure() based on what a
+	 * queuing will be set in device_configure() based on what a
 	 * device reports it is capable of in Inquiry byte 7.
 	 *
 	 * If SCSI Bus Resets have been disabled, then directly set
@@ -7219,7 +7219,7 @@ static void AscAsyncFix(ASC_DVC_VAR *asc_dvc, struc=
t scsi_device *sdev)
 }
=20
 static void
-advansys_narrow_slave_configure(struct scsi_device *sdev, ASC_DVC_VAR *a=
sc_dvc)
+advansys_narrow_device_configure(struct scsi_device *sdev, ASC_DVC_VAR *=
asc_dvc)
 {
 	ASC_SCSI_BIT_ID_TYPE tid_bit =3D 1 << sdev->id;
 	ASC_SCSI_BIT_ID_TYPE orig_use_tagged_qng =3D asc_dvc->use_tagged_qng;
@@ -7345,7 +7345,7 @@ static void advansys_wide_enable_ppr(ADV_DVC_VAR *a=
dv_dvc,
 }
=20
 static void
-advansys_wide_slave_configure(struct scsi_device *sdev, ADV_DVC_VAR *adv=
_dvc)
+advansys_wide_device_configure(struct scsi_device *sdev, ADV_DVC_VAR *ad=
v_dvc)
 {
 	AdvPortAddr iop_base =3D adv_dvc->iop_base;
 	unsigned short tidmask =3D 1 << sdev->id;
@@ -7391,16 +7391,17 @@ advansys_wide_slave_configure(struct scsi_device =
*sdev, ADV_DVC_VAR *adv_dvc)
  * Set the number of commands to queue per device for the
  * specified host adapter.
  */
-static int advansys_slave_configure(struct scsi_device *sdev)
+static int advansys_device_configure(struct scsi_device *sdev,
+				     struct queue_limits *lim)
 {
 	struct asc_board *boardp =3D shost_priv(sdev->host);
=20
 	if (ASC_NARROW_BOARD(boardp))
-		advansys_narrow_slave_configure(sdev,
-						&boardp->dvc_var.asc_dvc_var);
+		advansys_narrow_device_configure(sdev,
+						 &boardp->dvc_var.asc_dvc_var);
 	else
-		advansys_wide_slave_configure(sdev,
-						&boardp->dvc_var.adv_dvc_var);
+		advansys_wide_device_configure(sdev,
+					       &boardp->dvc_var.adv_dvc_var);
=20
 	return 0;
 }
@@ -10612,7 +10613,7 @@ static const struct scsi_host_template advansys_t=
emplate =3D {
 	.queuecommand =3D advansys_queuecommand,
 	.eh_host_reset_handler =3D advansys_reset,
 	.bios_param =3D advansys_biosparam,
-	.slave_configure =3D advansys_slave_configure,
+	.device_configure =3D advansys_device_configure,
 	.cmd_size =3D sizeof(struct advansys_cmd),
 };
=20
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/ai=
c79xx_osm.c
index 1bf60a8d01cf..997796bbe350 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -701,7 +701,7 @@ ahd_linux_device_alloc(struct scsi_device *sdev)
 }
=20
 static int
-ahd_linux_slave_configure(struct scsi_device *sdev)
+ahd_linux_device_configure(struct scsi_device *sdev, struct queue_limits=
 *lim)
 {
 	if (bootverbose)
 		sdev_printk(KERN_INFO, sdev, "Slave Configure\n");
@@ -907,7 +907,7 @@ struct scsi_host_template aic79xx_driver_template =3D=
 {
 	.max_sectors		=3D 8192,
 	.cmd_per_lun		=3D 2,
 	.device_alloc		=3D ahd_linux_device_alloc,
-	.slave_configure	=3D ahd_linux_slave_configure,
+	.device_configure	=3D ahd_linux_device_configure,
 	.target_alloc		=3D ahd_linux_target_alloc,
 	.target_destroy		=3D ahd_linux_target_destroy,
 };
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/ai=
c7xxx_osm.c
index 5724e8940ea8..15ab6c2131fc 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -664,7 +664,7 @@ ahc_linux_device_alloc(struct scsi_device *sdev)
 }
=20
 static int
-ahc_linux_slave_configure(struct scsi_device *sdev)
+ahc_linux_device_configure(struct scsi_device *sdev, struct queue_limits=
 *lim)
 {
 	if (bootverbose)
 		sdev_printk(KERN_INFO, sdev, "Slave Configure\n");
@@ -792,7 +792,7 @@ struct scsi_host_template aic7xxx_driver_template =3D=
 {
 	.max_sectors		=3D 8192,
 	.cmd_per_lun		=3D 2,
 	.device_alloc		=3D ahc_linux_device_alloc,
-	.slave_configure	=3D ahc_linux_slave_configure,
+	.device_configure	=3D ahc_linux_device_configure,
 	.target_alloc		=3D ahc_linux_target_alloc,
 	.target_destroy		=3D ahc_linux_target_destroy,
 };
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcms=
r_hba.c
index 35860c61468b..b48464dfa278 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -143,7 +143,8 @@ static irqreturn_t arcmsr_interrupt(struct AdapterCon=
trolBlock *acb);
 static void arcmsr_free_irq(struct pci_dev *, struct AdapterControlBlock=
 *);
 static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb);
 static void arcmsr_set_iop_datetime(struct timer_list *);
-static int arcmsr_slave_config(struct scsi_device *sdev);
+static int arcmsr_device_configure(struct scsi_device *sdev,
+				   struct queue_limits *lim);
 static int arcmsr_adjust_disk_queue_depth(struct scsi_device *sdev, int =
queue_depth)
 {
 	if (queue_depth > ARCMSR_MAX_CMD_PERLUN)
@@ -160,7 +161,7 @@ static const struct scsi_host_template arcmsr_scsi_ho=
st_template =3D {
 	.eh_abort_handler	=3D arcmsr_abort,
 	.eh_bus_reset_handler	=3D arcmsr_bus_reset,
 	.bios_param		=3D arcmsr_bios_param,
-	.slave_configure	=3D arcmsr_slave_config,
+	.device_configure	=3D arcmsr_device_configure,
 	.change_queue_depth	=3D arcmsr_adjust_disk_queue_depth,
 	.can_queue		=3D ARCMSR_DEFAULT_OUTSTANDING_CMD,
 	.this_id		=3D ARCMSR_SCSI_INITIATOR_ID,
@@ -3344,7 +3345,8 @@ static int arcmsr_queue_command_lck(struct scsi_cmn=
d *cmd)
=20
 static DEF_SCSI_QCMD(arcmsr_queue_command)
=20
-static int arcmsr_slave_config(struct scsi_device *sdev)
+static int arcmsr_device_configure(struct scsi_device *sdev,
+				   struct queue_limits *lim)
 {
 	unsigned int	dev_timeout;
=20
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index b749715cd49c..493005c791cf 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -783,7 +783,7 @@ bfad_thread_workq(struct bfad_s *bfad)
  * Return non-zero if fails.
  */
 static int
-bfad_im_slave_configure(struct scsi_device *sdev)
+bfad_im_device_configure(struct scsi_device *sdev, struct queue_limits *=
lim)
 {
 	scsi_change_queue_depth(sdev, bfa_lun_queue_depth);
 	return 0;
@@ -801,7 +801,7 @@ struct scsi_host_template bfad_im_scsi_host_template =
=3D {
 	.eh_target_reset_handler =3D bfad_im_reset_target_handler,
=20
 	.device_alloc =3D bfad_im_device_alloc,
-	.slave_configure =3D bfad_im_slave_configure,
+	.device_configure =3D bfad_im_device_configure,
 	.device_destroy =3D bfad_im_device_destroy,
=20
 	.this_id =3D -1,
@@ -824,7 +824,7 @@ struct scsi_host_template bfad_im_vport_template =3D =
{
 	.eh_target_reset_handler =3D bfad_im_reset_target_handler,
=20
 	.device_alloc =3D bfad_im_device_alloc,
-	.slave_configure =3D bfad_im_slave_configure,
+	.device_configure =3D bfad_im_device_configure,
 	.device_destroy =3D bfad_im_device_destroy,
=20
 	.this_id =3D -1,
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2=
fc_fcoe.c
index b2d6947cffc4..1ee5d4346eca 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2652,7 +2652,8 @@ static int bnx2fc_cpu_offline(unsigned int cpu)
 	return 0;
 }
=20
-static int bnx2fc_slave_configure(struct scsi_device *sdev)
+static int bnx2fc_device_configure(struct scsi_device *sdev,
+				   struct queue_limits *lim)
 {
 	if (!bnx2fc_queue_depth)
 		return 0;
@@ -2959,7 +2960,7 @@ static struct scsi_host_template bnx2fc_shost_templ=
ate =3D {
 	.dma_boundary           =3D 0x7fff,
 	.max_sectors		=3D 0x3fbf,
 	.track_queue_depth	=3D 1,
-	.slave_configure	=3D bnx2fc_slave_configure,
+	.device_configure	=3D bnx2fc_device_configure,
 	.shost_groups		=3D bnx2fc_host_groups,
 	.cmd_size		=3D sizeof(struct bnx2fc_priv),
 };
diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/cs=
io_scsi.c
index 68c6c8651b76..9ddba85acdb5 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -2237,7 +2237,7 @@ csio_device_alloc(struct scsi_device *sdev)
 }
=20
 static int
-csio_slave_configure(struct scsi_device *sdev)
+csio_device_configure(struct scsi_device *sdev, struct queue_limits *lim=
)
 {
 	scsi_change_queue_depth(sdev, csio_lun_qdepth);
 	return 0;
@@ -2277,7 +2277,7 @@ struct scsi_host_template csio_fcoe_shost_template =
=3D {
 	.eh_abort_handler	=3D csio_eh_abort_handler,
 	.eh_device_reset_handler =3D csio_eh_lun_reset_handler,
 	.device_alloc		=3D csio_device_alloc,
-	.slave_configure	=3D csio_slave_configure,
+	.device_configure	=3D csio_device_configure,
 	.device_destroy		=3D csio_device_destroy,
 	.scan_finished		=3D csio_scan_finished,
 	.this_id		=3D -1,
@@ -2296,7 +2296,7 @@ struct scsi_host_template csio_fcoe_shost_vport_tem=
plate =3D {
 	.eh_abort_handler	=3D csio_eh_abort_handler,
 	.eh_device_reset_handler =3D csio_eh_lun_reset_handler,
 	.device_alloc		=3D csio_device_alloc,
-	.slave_configure	=3D csio_slave_configure,
+	.device_configure	=3D csio_device_configure,
 	.device_destroy		=3D csio_device_destroy,
 	.scan_finished		=3D csio_scan_finished,
 	.this_id		=3D -1,
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index a754318eca70..889e8e6cab2c 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2261,7 +2261,7 @@ static void esp_init_swstate(struct esp *esp)
 	INIT_LIST_HEAD(&esp->active_cmds);
 	INIT_LIST_HEAD(&esp->esp_cmd_pool);
=20
-	/* Start with a clear state, domain validation (via ->slave_configure,
+	/* Start with a clear state, domain validation (via ->device_configure,
 	 * spi_dv_device()) will attempt to enable SYNC, WIDE, and tagged
 	 * commands.
 	 */
@@ -2463,7 +2463,8 @@ static int esp_device_alloc(struct scsi_device *dev=
)
 	return 0;
 }
=20
-static int esp_slave_configure(struct scsi_device *dev)
+static int esp_device_configure(struct scsi_device *dev,
+				struct queue_limits *lim)
 {
 	struct esp *esp =3D shost_priv(dev->host);
 	struct esp_target_data *tp =3D &esp->target[dev->id];
@@ -2668,7 +2669,7 @@ const struct scsi_host_template scsi_esp_template =3D=
 {
 	.target_alloc		=3D esp_target_alloc,
 	.target_destroy		=3D esp_target_destroy,
 	.device_alloc		=3D esp_device_alloc,
-	.slave_configure	=3D esp_slave_configure,
+	.device_configure	=3D esp_device_configure,
 	.device_destroy		=3D esp_device_destroy,
 	.eh_abort_handler	=3D esp_eh_abort_handler,
 	.eh_bus_reset_handler	=3D esp_eh_bus_reset_handler,
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index ba0a85ddb7fe..16e0f8fae04b 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -284,7 +284,8 @@ static int hpsa_change_queue_depth(struct scsi_device=
 *sdev, int qdepth);
=20
 static int hpsa_eh_device_reset_handler(struct scsi_cmnd *scsicmd);
 static int hpsa_device_alloc(struct scsi_device *sdev);
-static int hpsa_slave_configure(struct scsi_device *sdev);
+static int hpsa_device_configure(struct scsi_device *sdev,
+				 struct queue_limits *lim);
 static void hpsa_device_destroy(struct scsi_device *sdev);
=20
 static void hpsa_update_scsi_devices(struct ctlr_info *h);
@@ -979,7 +980,7 @@ static const struct scsi_host_template hpsa_driver_te=
mplate =3D {
 	.eh_device_reset_handler =3D hpsa_eh_device_reset_handler,
 	.ioctl			=3D hpsa_ioctl,
 	.device_alloc		=3D hpsa_device_alloc,
-	.slave_configure	=3D hpsa_slave_configure,
+	.device_configure	=3D hpsa_device_configure,
 	.device_destroy		=3D hpsa_device_destroy,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		=3D hpsa_compat_ioctl,
@@ -2142,7 +2143,8 @@ static int hpsa_device_alloc(struct scsi_device *sd=
ev)
=20
 /* configure scsi device based on internal per-device structure */
 #define CTLR_TIMEOUT (120 * HZ)
-static int hpsa_slave_configure(struct scsi_device *sdev)
+static int hpsa_device_configure(struct scsi_device *sdev,
+				 struct queue_limits *lim)
 {
 	struct hpsa_scsi_dev_t *sd;
 	int queue_depth;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvf=
c.c
index 689c45e08d28..7308e2cb347f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3441,7 +3441,7 @@ static int ibmvfc_target_alloc(struct scsi_target *=
starget)
 }
=20
 /**
- * ibmvfc_slave_configure - Configure the device
+ * ibmvfc_device_configure - Configure the device
  * @sdev:	struct scsi_device device to configure
  *
  * Enable allow_restart for a device if it is a disk. Adjust the
@@ -3450,7 +3450,8 @@ static int ibmvfc_target_alloc(struct scsi_target *=
starget)
  * Returns:
  *	0
  **/
-static int ibmvfc_slave_configure(struct scsi_device *sdev)
+static int ibmvfc_device_configure(struct scsi_device *sdev,
+				   struct queue_limits *lim)
 {
 	struct Scsi_Host *shost =3D sdev->host;
 	unsigned long flags =3D 0;
@@ -3697,7 +3698,7 @@ static const struct scsi_host_template driver_templ=
ate =3D {
 	.eh_target_reset_handler =3D ibmvfc_eh_target_reset_handler,
 	.eh_host_reset_handler =3D ibmvfc_eh_host_reset_handler,
 	.device_alloc =3D ibmvfc_device_alloc,
-	.slave_configure =3D ibmvfc_slave_configure,
+	.device_configure =3D ibmvfc_device_configure,
 	.target_alloc =3D ibmvfc_target_alloc,
 	.scan_finished =3D ibmvfc_scan_finished,
 	.change_queue_depth =3D ibmvfc_change_queue_depth,
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibm=
vscsi.c
index 71f3e9563520..64f368a59c55 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1860,14 +1860,16 @@ static void ibmvscsi_handle_crq(struct viosrp_crq=
 *crq,
 }
=20
 /**
- * ibmvscsi_slave_configure: Set the "allow_restart" flag for each disk.
+ * ibmvscsi_device_configure: Set the "allow_restart" flag for each disk=
.
  * @sdev:	struct scsi_device device to configure
+ * @lim:	Request queue limits
  *
  * Enable allow_restart for a device if it is a disk.  Adjust the
  * queue_depth here also as is required by the documentation for
  * struct scsi_host_template.
  */
-static int ibmvscsi_slave_configure(struct scsi_device *sdev)
+static int ibmvscsi_device_configure(struct scsi_device *sdev,
+				     struct queue_limits *lim)
 {
 	struct Scsi_Host *shost =3D sdev->host;
 	unsigned long lock_flags =3D 0;
@@ -2091,7 +2093,7 @@ static struct scsi_host_template driver_template =3D=
 {
 	.eh_abort_handler =3D ibmvscsi_eh_abort_handler,
 	.eh_device_reset_handler =3D ibmvscsi_eh_device_reset_handler,
 	.eh_host_reset_handler =3D ibmvscsi_eh_host_reset_handler,
-	.slave_configure =3D ibmvscsi_slave_configure,
+	.device_configure =3D ibmvscsi_device_configure,
 	.change_queue_depth =3D ibmvscsi_change_queue_depth,
 	.host_reset =3D ibmvscsi_host_reset,
 	.cmd_per_lun =3D IBMVSCSI_CMDS_PER_LUN_DEFAULT,
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 10cf5775a939..549b9198513d 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -364,7 +364,7 @@ static struct scsi_host_template ips_driver_template =
=3D {
 	.proc_name		=3D "ips",
 	.show_info		=3D ips_show_info,
 	.write_info		=3D ips_write_info,
-	.slave_configure	=3D ips_slave_configure,
+	.device_configure	=3D ips_device_configure,
 	.bios_param		=3D ips_biosparam,
 	.this_id		=3D -1,
 	.sg_tablesize		=3D IPS_MAX_SG,
@@ -1166,7 +1166,7 @@ static int ips_biosparam(struct scsi_device *sdev, =
struct block_device *bdev,
=20
 /***********************************************************************=
*****/
 /*                                                                      =
    */
-/* Routine Name: ips_slave_configure                                    =
    */
+/* Routine Name: ips_device_configure                                   =
    */
 /*                                                                      =
    */
 /* Routine Description:                                                 =
    */
 /*                                                                      =
    */
@@ -1174,7 +1174,7 @@ static int ips_biosparam(struct scsi_device *sdev, =
struct block_device *bdev,
 /*                                                                      =
    */
 /***********************************************************************=
*****/
 static int
-ips_slave_configure(struct scsi_device * SDptr)
+ips_device_configure(struct scsi_device *SDptr, struct queue_limits *lim=
)
 {
 	ips_ha_t *ha;
 	int min;
diff --git a/drivers/scsi/ips.h b/drivers/scsi/ips.h
index 65edf000e447..1c7c61c66671 100644
--- a/drivers/scsi/ips.h
+++ b/drivers/scsi/ips.h
@@ -400,7 +400,8 @@
     */
    static int ips_biosparam(struct scsi_device *sdev, struct block_devic=
e *bdev,
 		sector_t capacity, int geom[]);
-   static int ips_slave_configure(struct scsi_device *SDptr);
+   static int ips_device_configure(struct scsi_device *SDptr,
+				   struct queue_limits *lim);
=20
 /*
  * Raid Command Formats
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.=
c
index f0d6b6bbaae1..4f29be625a89 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -6342,8 +6342,9 @@ lpfc_device_alloc(struct scsi_device *sdev)
 }
=20
 /**
- * lpfc_slave_configure - scsi_host_template slave_configure entry point
+ * lpfc_device_configure - scsi_host_template device_configure entry poi=
nt
  * @sdev: Pointer to scsi_device.
+ * @lim: Request queue limits.
  *
  * This routine configures following items
  *   - Tag command queuing support for @sdev if supported.
@@ -6353,7 +6354,7 @@ lpfc_device_alloc(struct scsi_device *sdev)
  *   0 - Success
  **/
 static int
-lpfc_slave_configure(struct scsi_device *sdev)
+lpfc_device_configure(struct scsi_device *sdev, struct queue_limits *lim=
)
 {
 	struct lpfc_vport *vport =3D (struct lpfc_vport *) sdev->host->hostdata=
;
 	struct lpfc_hba   *phba =3D vport->phba;
@@ -6737,7 +6738,13 @@ lpfc_no_command(struct Scsi_Host *shost, struct sc=
si_cmnd *cmnd)
 }
=20
 static int
-lpfc_no_device(struct scsi_device *sdev)
+lpfc_alloc_no_device(struct scsi_device *sdev)
+{
+	return -ENODEV;
+}
+
+static int
+lpfc_config_no_device(struct scsi_device *sdev, struct queue_limits *lim=
)
 {
 	return -ENODEV;
 }
@@ -6748,8 +6755,8 @@ struct scsi_host_template lpfc_template_nvme =3D {
 	.proc_name		=3D LPFC_DRIVER_NAME,
 	.info			=3D lpfc_info,
 	.queuecommand		=3D lpfc_no_command,
-	.device_alloc		=3D lpfc_no_device,
-	.slave_configure	=3D lpfc_no_device,
+	.device_alloc		=3D lpfc_alloc_no_device,
+	.device_configure	=3D lpfc_config_no_device,
 	.scan_finished		=3D lpfc_scan_finished,
 	.this_id		=3D -1,
 	.sg_tablesize		=3D 1,
@@ -6773,7 +6780,7 @@ struct scsi_host_template lpfc_template =3D {
 	.eh_target_reset_handler =3D lpfc_target_reset_handler,
 	.eh_host_reset_handler  =3D lpfc_host_reset_handler,
 	.device_alloc		=3D lpfc_device_alloc,
-	.slave_configure	=3D lpfc_slave_configure,
+	.device_configure	=3D lpfc_device_configure,
 	.device_destroy		=3D lpfc_device_destroy,
 	.scan_finished		=3D lpfc_scan_finished,
 	.this_id		=3D -1,
@@ -6800,7 +6807,7 @@ struct scsi_host_template lpfc_vport_template =3D {
 	.eh_bus_reset_handler	=3D NULL,
 	.eh_host_reset_handler	=3D NULL,
 	.device_alloc		=3D lpfc_device_alloc,
-	.slave_configure	=3D lpfc_slave_configure,
+	.device_configure	=3D lpfc_device_configure,
 	.device_destroy		=3D lpfc_device_destroy,
 	.scan_finished		=3D lpfc_scan_finished,
 	.this_id		=3D -1,
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index d9d366ec17dc..52d56b8d708c 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2000,7 +2000,8 @@ static struct mvumi_instance_template mvumi_instanc=
e_9580 =3D {
 	.reset_host =3D mvumi_reset_host_9580,
 };
=20
-static int mvumi_slave_configure(struct scsi_device *sdev)
+static int mvumi_device_configure(struct scsi_device *sdev,
+				  struct queue_limits *lim)
 {
 	struct mvumi_hba *mhba;
 	unsigned char bitcount =3D sizeof(unsigned char) * 8;
@@ -2172,7 +2173,7 @@ static const struct scsi_host_template mvumi_templa=
te =3D {
=20
 	.module =3D THIS_MODULE,
 	.name =3D "Marvell Storage Controller",
-	.slave_configure =3D mvumi_slave_configure,
+	.device_configure =3D mvumi_device_configure,
 	.queuecommand =3D mvumi_queue_command,
 	.eh_timed_out =3D mvumi_timed_out,
 	.eh_host_reset_handler =3D mvumi_host_reset,
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index fe39d95d0bdd..24d6b22e3627 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1715,7 +1715,8 @@ static int myrb_device_alloc(struct scsi_device *sd=
ev)
 	return myrb_pdev_device_alloc(sdev);
 }
=20
-static int myrb_slave_configure(struct scsi_device *sdev)
+static int myrb_device_configure(struct scsi_device *sdev,
+				 struct queue_limits *lim)
 {
 	struct myrb_ldev_info *ldev_info;
=20
@@ -2209,7 +2210,7 @@ static const struct scsi_host_template myrb_templat=
e =3D {
 	.queuecommand		=3D myrb_queuecommand,
 	.eh_host_reset_handler	=3D myrb_host_reset,
 	.device_alloc		=3D myrb_device_alloc,
-	.slave_configure	=3D myrb_slave_configure,
+	.device_configure	=3D myrb_device_configure,
 	.device_destroy		=3D myrb_device_destroy,
 	.bios_param		=3D myrb_biosparam,
 	.cmd_size		=3D sizeof(struct myrb_cmdblk),
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 56557addbcca..352f34e14195 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1882,7 +1882,8 @@ static int myrs_device_alloc(struct scsi_device *sd=
ev)
 	return 0;
 }
=20
-static int myrs_slave_configure(struct scsi_device *sdev)
+static int myrs_device_configure(struct scsi_device *sdev,
+				 struct queue_limits *lim)
 {
 	struct myrs_hba *cs =3D shost_priv(sdev->host);
 	struct myrs_ldev_info *ldev_info;
@@ -1922,7 +1923,7 @@ static const struct scsi_host_template myrs_templat=
e =3D {
 	.queuecommand		=3D myrs_queuecommand,
 	.eh_host_reset_handler	=3D myrs_host_reset,
 	.device_alloc		=3D myrs_device_alloc,
-	.slave_configure	=3D myrs_slave_configure,
+	.device_configure	=3D myrs_device_configure,
 	.device_destroy		=3D myrs_device_destroy,
 	.cmd_size		=3D sizeof(struct myrs_cmdblk),
 	.shost_groups		=3D myrs_shost_groups,
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 59821966d54d..3e4bdd212644 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -7796,7 +7796,8 @@ static int ncr53c8xx_device_alloc(struct scsi_devic=
e *device)
 	return 0;
 }
=20
-static int ncr53c8xx_slave_configure(struct scsi_device *device)
+static int ncr53c8xx_device_configure(struct scsi_device *device,
+				      struct queue_limits *lim)
 {
 	struct Scsi_Host *host =3D device->host;
 	struct ncb *np =3D ((struct host_data *) host->hostdata)->ncb;
@@ -8093,7 +8094,7 @@ struct Scsi_Host * __init ncr_attach(struct scsi_ho=
st_template *tpnt,
 		tpnt->shost_groups =3D ncr53c8xx_host_groups;
=20
 	tpnt->queuecommand	=3D ncr53c8xx_queue_command;
-	tpnt->slave_configure	=3D ncr53c8xx_slave_configure;
+	tpnt->device_configure	=3D ncr53c8xx_device_configure;
 	tpnt->device_alloc	=3D ncr53c8xx_device_alloc;
 	tpnt->eh_bus_reset_handler =3D ncr53c8xx_bus_reset;
 	tpnt->can_queue		=3D SCSI_NCR_CAN_QUEUE;
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index 90495a832f34..dcf911d68cf8 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -61,7 +61,8 @@ enum lv1_atapi_in_out {
 };
=20
=20
-static int ps3rom_slave_configure(struct scsi_device *scsi_dev)
+static int ps3rom_device_configure(struct scsi_device *scsi_dev,
+				   struct queue_limits *lim)
 {
 	struct ps3rom_private *priv =3D shost_priv(scsi_dev->host);
 	struct ps3_storage_device *dev =3D priv->dev;
@@ -325,7 +326,7 @@ static irqreturn_t ps3rom_interrupt(int irq, void *da=
ta)
=20
 static const struct scsi_host_template ps3rom_host_template =3D {
 	.name =3D			DEVICE_NAME,
-	.slave_configure =3D	ps3rom_slave_configure,
+	.device_configure =3D	ps3rom_device_configure,
 	.queuecommand =3D		ps3rom_queuecommand,
 	.can_queue =3D		1,
 	.this_id =3D		7,
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.=
c
index cf13148ba281..ff2acaebf0be 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -982,7 +982,8 @@ static int qedf_eh_host_reset(struct scsi_cmnd *sc_cm=
d)
 	return SUCCESS;
 }
=20
-static int qedf_slave_configure(struct scsi_device *sdev)
+static int qedf_device_configure(struct scsi_device *sdev,
+				 struct queue_limits *lim)
 {
 	if (qedf_queue_depth) {
 		scsi_change_queue_depth(sdev, qedf_queue_depth);
@@ -1003,7 +1004,7 @@ static const struct scsi_host_template qedf_host_te=
mplate =3D {
 	.eh_device_reset_handler =3D qedf_eh_device_reset, /* lun reset */
 	.eh_target_reset_handler =3D qedf_eh_target_reset, /* target reset */
 	.eh_host_reset_handler  =3D qedf_eh_host_reset,
-	.slave_configure	=3D qedf_slave_configure,
+	.device_configure	=3D qedf_device_configure,
 	.dma_boundary =3D QED_HW_DMA_BOUNDARY,
 	.sg_tablesize =3D QEDF_MAX_BDS_PER_CMD,
 	.can_queue =3D FCOE_PARAMS_NUM_TASKS,
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 8958547ac111..2eed63f6faf6 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1159,7 +1159,7 @@ qla1280_set_target_parameters(struct scsi_qla_host =
*ha, int bus, int target)
=20
=20
 /***********************************************************************=
***
- *   qla1280_slave_configure
+ *   qla1280_device_configure
  *
  * Description:
  *   Determines the queue depth for a given device.  There are two ways
@@ -1170,7 +1170,7 @@ qla1280_set_target_parameters(struct scsi_qla_host =
*ha, int bus, int target)
  *   default queue depth (dependent on the number of hardware SCBs).
  ***********************************************************************=
***/
 static int
-qla1280_slave_configure(struct scsi_device *device)
+qla1280_device_configure(struct scsi_device *device, struct queue_limits=
 *lim)
 {
 	struct scsi_qla_host *ha;
 	int default_depth =3D 3;
@@ -4121,7 +4121,7 @@ static const struct scsi_host_template qla1280_driv=
er_template =3D {
 	.proc_name		=3D "qla1280",
 	.name			=3D "Qlogic ISP 1280/12160",
 	.info			=3D qla1280_info,
-	.slave_configure	=3D qla1280_slave_configure,
+	.device_configure	=3D qla1280_device_configure,
 	.queuecommand		=3D qla1280_queuecommand,
 	.eh_abort_handler	=3D qla1280_eh_abort,
 	.eh_device_reset_handler=3D qla1280_eh_device_reset,
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.=
c
index 47d7faf9b4d5..1d0e7b38c6b3 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1947,7 +1947,7 @@ qla2xxx_device_alloc(struct scsi_device *sdev)
 }
=20
 static int
-qla2xxx_slave_configure(struct scsi_device *sdev)
+qla2xxx_device_configure(struct scsi_device *sdev, struct queue_limits *=
lim)
 {
 	scsi_qla_host_t *vha =3D shost_priv(sdev->host);
 	struct req_que *req =3D vha->req;
@@ -8086,7 +8086,7 @@ struct scsi_host_template qla2xxx_driver_template =3D=
 {
 	.eh_bus_reset_handler	=3D qla2xxx_eh_bus_reset,
 	.eh_host_reset_handler	=3D qla2xxx_eh_host_reset,
=20
-	.slave_configure	=3D qla2xxx_slave_configure,
+	.device_configure	=3D qla2xxx_device_configure,
=20
 	.device_alloc		=3D qla2xxx_device_alloc,
 	.device_destroy		=3D qla2xxx_device_destroy,
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 6177f4798f3a..304ef95587e2 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -975,7 +975,8 @@ static inline void update_can_queue(struct Scsi_Host =
*host, u_int in_ptr, u_int
 	host->sg_tablesize =3D QLOGICPTI_MAX_SG(num_free);
 }
=20
-static int qlogicpti_slave_configure(struct scsi_device *sdev)
+static int qlogicpti_device_configure(struct scsi_device *sdev,
+				      struct queue_limits *lim)
 {
 	struct qlogicpti *qpti =3D shost_priv(sdev->host);
 	int tgt =3D sdev->id;
@@ -1292,7 +1293,7 @@ static const struct scsi_host_template qpti_templat=
e =3D {
 	.name			=3D "qlogicpti",
 	.info			=3D qlogicpti_info,
 	.queuecommand		=3D qlogicpti_queuecommand,
-	.slave_configure	=3D qlogicpti_slave_configure,
+	.device_configure	=3D qlogicpti_device_configure,
 	.eh_abort_handler	=3D qlogicpti_abort,
 	.eh_host_reset_handler	=3D qlogicpti_reset,
 	.can_queue		=3D QLOGICPTI_REQ_QUEUE_LEN,
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 59782c2d8053..ae4841a97619 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5890,14 +5890,15 @@ static int scsi_debug_device_alloc(struct scsi_de=
vice *sdp)
 	return 0;
 }
=20
-static int scsi_debug_slave_configure(struct scsi_device *sdp)
+static int scsi_debug_device_configure(struct scsi_device *sdp,
+				       struct queue_limits *lim)
 {
 	struct sdebug_dev_info *devip =3D
 			(struct sdebug_dev_info *)sdp->hostdata;
 	struct dentry *dentry;
=20
 	if (sdebug_verbose)
-		pr_info("slave_configure <%u %u %u %llu>\n",
+		pr_info("device_configure <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
 	if (sdp->host->max_cmd_len !=3D SDEBUG_MAX_CMD_LEN)
 		sdp->host->max_cmd_len =3D SDEBUG_MAX_CMD_LEN;
@@ -8715,7 +8716,7 @@ static struct scsi_host_template sdebug_driver_temp=
late =3D {
 	.name =3D			"SCSI DEBUG",
 	.info =3D			scsi_debug_info,
 	.device_alloc =3D		scsi_debug_device_alloc,
-	.slave_configure =3D	scsi_debug_slave_configure,
+	.device_configure =3D	scsi_debug_device_configure,
 	.device_destroy =3D	scsi_debug_device_destroy,
 	.ioctl =3D		scsi_debug_ioctl,
 	.queuecommand =3D		scsi_debug_queuecommand,
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 88b8acfdacd4..05ea1e781d21 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -316,7 +316,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scs=
i_target *starget,
 	sdev->hostdata =3D hostdata;
=20
 	/* if the device needs this changing, it may do so in the
-	 * slave_configure function */
+	 * device_configure function */
 	sdev->max_device_blocked =3D SCSI_DEFAULT_DEVICE_BLOCKED;
=20
 	/*
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpq=
i/smartpqi_init.c
index 2535138544ed..41cbf8784a20 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6558,7 +6558,8 @@ static inline bool pqi_is_tape_changer_device(struc=
t pqi_scsi_dev *device)
 	return device->devtype =3D=3D TYPE_TAPE || device->devtype =3D=3D TYPE_=
MEDIUM_CHANGER;
 }
=20
-static int pqi_slave_configure(struct scsi_device *sdev)
+static int pqi_device_configure(struct scsi_device *sdev,
+				struct queue_limits *lim)
 {
 	int rc =3D 0;
 	struct pqi_scsi_dev *device;
@@ -7550,7 +7551,7 @@ static const struct scsi_host_template pqi_driver_t=
emplate =3D {
 	.eh_abort_handler =3D pqi_eh_abort_handler,
 	.ioctl =3D pqi_ioctl,
 	.device_alloc =3D pqi_device_alloc,
-	.slave_configure =3D pqi_slave_configure,
+	.device_configure =3D pqi_device_configure,
 	.device_destroy =3D pqi_device_destroy,
 	.map_queues =3D pqi_map_queues,
 	.sdev_groups =3D pqi_sdev_groups,
diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.=
c
index a5dd3deaec26..f69075b9951c 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -57,11 +57,11 @@ snic_device_alloc(struct scsi_device *sdev)
 }
=20
 /*
- * snic_slave_configure : callback function to SCSI Mid Layer, called on
+ * snic_device_configure : callback function to SCSI Mid Layer, called o=
n
  * scsi device initialization.
  */
 static int
-snic_slave_configure(struct scsi_device *sdev)
+snic_device_configure(struct scsi_device *sdev, struct queue_limits *lim=
)
 {
 	struct snic *snic =3D shost_priv(sdev->host);
 	u32 qdepth =3D 0, max_ios =3D 0;
@@ -108,7 +108,7 @@ static const struct scsi_host_template snic_host_temp=
late =3D {
 	.eh_device_reset_handler =3D snic_device_reset,
 	.eh_host_reset_handler =3D snic_host_reset,
 	.device_alloc =3D snic_device_alloc,
-	.slave_configure =3D snic_slave_configure,
+	.device_configure =3D snic_device_configure,
 	.change_queue_depth =3D snic_change_queue_depth,
 	.this_id =3D -1,
 	.cmd_per_lun =3D SNIC_DFLT_QUEUE_DEPTH,
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 0e81125df8c7..3c4050617ea2 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -584,7 +584,7 @@ static void return_abnormal_state(struct st_hba *hba,=
 int status)
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 }
 static int
-stex_slave_config(struct scsi_device *sdev)
+stex_device_configure(struct scsi_device *sdev, struct queue_limits *lim=
)
 {
 	sdev->use_10_for_rw =3D 1;
 	sdev->use_10_for_ms =3D 1;
@@ -1481,7 +1481,7 @@ static const struct scsi_host_template driver_templ=
ate =3D {
 	.proc_name			=3D DRV_NAME,
 	.bios_param			=3D stex_biosparam,
 	.queuecommand			=3D stex_queuecommand,
-	.slave_configure		=3D stex_slave_config,
+	.device_configure		=3D stex_device_configure,
 	.eh_abort_handler		=3D stex_abort,
 	.eh_host_reset_handler		=3D stex_reset,
 	.this_id			=3D -1,
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6487b029ca9f..bfbb330d69c8 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1574,7 +1574,8 @@ static int storvsc_device_alloc(struct scsi_device =
*sdevice)
 	return 0;
 }
=20
-static int storvsc_device_configure(struct scsi_device *sdevice)
+static int storvsc_device_configure(struct scsi_device *sdevice,
+				    struct queue_limits *lim)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
=20
@@ -1876,7 +1877,7 @@ static struct scsi_host_template scsi_driver =3D {
 	.proc_name =3D		"storvsc_host",
 	.eh_timed_out =3D		storvsc_eh_timed_out,
 	.device_alloc =3D		storvsc_device_alloc,
-	.slave_configure =3D	storvsc_device_configure,
+	.device_configure =3D	storvsc_device_configure,
 	.cmd_per_lun =3D		2048,
 	.this_id =3D		-1,
 	/* Ensure there are no gaps in presented sgls */
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx=
_2/sym_glue.c
index 606196ff90f9..7c319f06c898 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -825,7 +825,8 @@ static int sym53c8xx_device_alloc(struct scsi_device =
*sdev)
 /*
  * Linux entry point for device queue sizing.
  */
-static int sym53c8xx_slave_configure(struct scsi_device *sdev)
+static int sym53c8xx_device_configure(struct scsi_device *sdev,
+				      struct queue_limits *lim)
 {
 	struct sym_hcb *np =3D sym_get_hcb(sdev->host);
 	struct sym_tcb *tp =3D &np->target[sdev->id];
@@ -1685,7 +1686,7 @@ static const struct scsi_host_template sym2_templat=
e =3D {
 	.cmd_size		=3D sizeof(struct sym_ucmd),
 	.queuecommand		=3D sym53c8xx_queue_command,
 	.device_alloc		=3D sym53c8xx_device_alloc,
-	.slave_configure	=3D sym53c8xx_slave_configure,
+	.device_configure	=3D sym53c8xx_device_configure,
 	.device_destroy		=3D sym53c8xx_device_destroy,
 	.eh_abort_handler	=3D sym53c8xx_eh_abort_handler,
 	.eh_target_reset_handler =3D sym53c8xx_eh_target_reset_handler,
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 068267c16cf6..6bf09b1dbff5 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -735,7 +735,8 @@ static int scsifront_dev_reset_handler(struct scsi_cm=
nd *sc)
 	return scsifront_action_handler(sc, VSCSIIF_ACT_SCSI_RESET);
 }
=20
-static int scsifront_sdev_configure(struct scsi_device *sdev)
+static int scsifront_sdev_configure(struct scsi_device *sdev,
+				    struct queue_limits *lim)
 {
 	struct vscsifrnt_info *info =3D shost_priv(sdev->host);
 	int err;
@@ -776,7 +777,7 @@ static const struct scsi_host_template scsifront_sht =
=3D {
 	.queuecommand		=3D scsifront_queuecommand,
 	.eh_abort_handler	=3D scsifront_eh_abort_handler,
 	.eh_device_reset_handler =3D scsifront_dev_reset_handler,
-	.slave_configure	=3D scsifront_sdev_configure,
+	.device_configure	=3D scsifront_sdev_configure,
 	.device_destroy		=3D scsifront_sdev_destroy,
 	.cmd_per_lun		=3D VSCSIIF_DEFAULT_CMD_PER_LUN,
 	.can_queue		=3D VSCSIIF_MAX_REQS,
@@ -1074,7 +1075,7 @@ static void scsifront_do_lun_hotplug(struct vscsifr=
nt_info *info, int op)
 			continue;
=20
 		/*
-		 * Front device state path, used in slave_configure called
+		 * Front device state path, used in device_configure called
 		 * on successfull scsi_add_device, and in device_destroy called
 		 * on remove of a device.
 		 */
diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rts=
x.c
index 5b481b4d835a..b7608d50458f 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -68,7 +68,7 @@ static int device_alloc(struct scsi_device *sdev)
 	return 0;
 }
=20
-static int slave_configure(struct scsi_device *sdev)
+static int device_configure(struct scsi_device *sdev, struct queue_limit=
s *lim)
 {
 	/* Set the SCSI level to at least 2.  We'll leave it at 3 if that's
 	 * what is originally reported.  We need this to avoid confusing
@@ -199,7 +199,7 @@ static const struct scsi_host_template rtsx_host_temp=
late =3D {
 	.this_id =3D			-1,
=20
 	.device_alloc =3D			device_alloc,
-	.slave_configure =3D		slave_configure,
+	.device_configure =3D		device_configure,
=20
 	/* lots of sg segments can be handled */
 	.sg_tablesize =3D			SG_ALL,

