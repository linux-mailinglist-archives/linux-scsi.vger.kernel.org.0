Return-Path: <linux-scsi+bounces-18056-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A3BDB351
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Oct 2025 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78F454EA2AF
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Oct 2025 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7430597F;
	Tue, 14 Oct 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LMdp2xXH"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240833064A7
	for <linux-scsi@vger.kernel.org>; Tue, 14 Oct 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473110; cv=none; b=qC0UiAQcku2cNSL++pWyc/uLBIAji3S3D+pcwtJZZpmCr1r8YBBn4e8pLsjaNJYUZDXOJM++svZLn7hRrrvnoy9BB8p02K1ZV1cHhCNCXE61CAxKDS3bHET2PA34kNYpgohndKpaFKmOkAV6Tp80b/LzBn+pJcmub+oDFF1pNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473110; c=relaxed/simple;
	bh=lYyJ495xcqc2MIQoTULvzk6HwO8bEdWQvOMkr6t6FWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc6jN7Zq/jQOUAleD81CK/rTKi/iLVirPhNRwgTx/yqfcrqy6zz4St1wtMaws5TCC4SI3glNfFGqHos6SaSQ/ZkZncmqUFwqUkftzss9S3T9uuIhQgC6yz6xFXq3f4duT0BEZ0BzCfbExqSXNSGel+Bm9U0u/CLivTVVnL8dM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LMdp2xXH; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cmQX32GBxzm0yV3;
	Tue, 14 Oct 2025 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1760473105; x=1763065106; bh=77ltO
	Ed+SDuzMT8VsZl3KCrfAGNaDdUzgfTv2MHLsvE=; b=LMdp2xXHNOaKwFIs/uU7/
	PluEfsFIAJ4HdpHs+fUAdKMDrPlvF9oYb5pXr3bAQaf6fmac2XdsaaJ9j4IWxcQ3
	bX6Me3ZjkAT/x5btGwHKd4JrfLWVzUkKuKJXSWmhDg32mySzAk71zCaHfxTet/Jk
	vT04EuJMGb4qo2KQwjHNZ/SG+4tpBFqABrZ3iUWWMhLA1Ei7mQlyXB6uDrK6WOT5
	ebfbfdzMM4FTb0Ylk+tajNZnTlGxUSJ2ZXnU+mJoNSrzv0r9/DYhPwsVLVPr7UjQ
	nakl8Dk8jQn7vknJHsxA1xpYc7yF1ytZD3awjaEv1Jzja1Uog4qhavovfBxb5LqC
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OV5pdV4fPsa6; Tue, 14 Oct 2025 20:18:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cmQWx4Kcqzm0yTq;
	Tue, 14 Oct 2025 20:18:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v6 04/28] scsi: core: Support allocating a pseudo SCSI device
Date: Tue, 14 Oct 2025 13:15:46 -0700
Message-ID: <20251014201707.3396650-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251014201707.3396650-1-bvanassche@acm.org>
References: <20251014201707.3396650-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Hannes Reinecke <hare@suse.de>

Allocate a pseudo SCSI device if 'nr_reserved_cmds' has been set. Pseudo
SCSI devices have the SCSI ID <max_id>:U64_MAX so they won't clash with
any devices the LLD might create. Pseudo SCSI devices are excluded from
scanning and will not show up in sysfs. Additionally, pseudo SCSI
devices are skipped by shost_for_each_device(). This prevents that the
SCSI error handler tries to submit a reset to a non-existent logical unit=
.

Do not allocate a budget map for pseudo SCSI devices since the
cmd_per_lun limit does not apply to pseudo SCSI devices.

Do not perform queue depth ramp up / ramp down for pseudo SCSI devices.

Pseudo SCSI devices will be used to send internal commands to a storage
device.

Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
[ bvanassche: edited patch description / renamed host_sdev into
  pseudo_sdev / unexported scsi_get_host_dev() / modified error path in
  scsi_get_pseudo_dev() / skip pseudo devices in __scsi_iterate_devices()
  and also when calling sdev_init(), sdev_configure() and sdev_destroy().
  See also
  https://lore.kernel.org/linux-scsi/20211125151048.103910-2-hare@suse.de=
/ ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hosts.c       |  8 +++++
 drivers/scsi/scsi.c        |  7 ++--
 drivers/scsi/scsi_priv.h   |  1 +
 drivers/scsi/scsi_scan.c   | 67 +++++++++++++++++++++++++++++++++++++-
 drivers/scsi/scsi_sysfs.c  |  5 ++-
 include/scsi/scsi_device.h | 16 +++++++++
 include/scsi/scsi_host.h   |  6 ++++
 7 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 9bb7f0114763..5a9a5e2f0004 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -307,6 +307,14 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, =
struct device *dev,
 	if (error)
 		goto out_del_dev;
=20
+	if (shost->nr_reserved_cmds) {
+		shost->pseudo_sdev =3D scsi_get_pseudo_dev(shost);
+		if (!shost->pseudo_sdev) {
+			error =3D -ENOMEM;
+			goto out_del_dev;
+		}
+	}
+
 	scsi_proc_host_add(shost);
 	scsi_autopm_put_host(shost);
 	return error;
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 589ae28b2c8b..2e37c42d173c 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -831,8 +831,11 @@ struct scsi_device *__scsi_iterate_devices(struct Sc=
si_Host *shost,
 	spin_lock_irqsave(shost->host_lock, flags);
 	while (list->next !=3D &shost->__devices) {
 		next =3D list_entry(list->next, struct scsi_device, siblings);
-		/* skip devices that we can't get a reference to */
-		if (!scsi_device_get(next))
+		/*
+		 * Skip pseudo devices and also devices for which
+		 * scsi_device_get() fails.
+		 */
+		if (!scsi_device_is_pseudo_dev(next) && !scsi_device_get(next))
 			break;
 		next =3D NULL;
 		list =3D list->next;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5b2b19f5e8ec..19d244ef1fa8 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -135,6 +135,7 @@ extern int scsi_complete_async_scans(void);
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, u64, enum scsi_scan_mode);
 extern void scsi_forget_host(struct Scsi_Host *);
+struct scsi_device *scsi_get_pseudo_dev(struct Scsi_Host *);
=20
 /* scsi_sysctl.c */
 #ifdef CONFIG_SYSCTL
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index de039efef290..5e7ef4655348 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -349,6 +349,9 @@ static struct scsi_device *scsi_alloc_sdev(struct scs=
i_target *starget,
=20
 	scsi_sysfs_device_initialize(sdev);
=20
+	if (scsi_device_is_pseudo_dev(sdev))
+		return sdev;
+
 	depth =3D sdev->host->cmd_per_lun ?: 1;
=20
 	/*
@@ -1070,6 +1073,9 @@ static int scsi_add_lun(struct scsi_device *sdev, u=
nsigned char *inq_result,
=20
 	sdev->sdev_bflags =3D *bflags;
=20
+	if (scsi_device_is_pseudo_dev(sdev))
+		return SCSI_SCAN_LUN_PRESENT;
+
 	/*
 	 * No need to freeze the queue as it isn't reachable to anyone else yet=
.
 	 */
@@ -1213,6 +1219,12 @@ static int scsi_probe_and_add_lun(struct scsi_targ=
et *starget,
 	if (!sdev)
 		goto out;
=20
+	if (scsi_device_is_pseudo_dev(sdev)) {
+		if (bflagsp)
+			*bflagsp =3D BLIST_NOLUN;
+		return SCSI_SCAN_LUN_PRESENT;
+	}
+
 	result =3D kmalloc(result_len, GFP_KERNEL);
 	if (!result)
 		goto out_free_sdev;
@@ -2084,12 +2096,65 @@ void scsi_forget_host(struct Scsi_Host *shost)
  restart:
 	spin_lock_irqsave(shost->host_lock, flags);
 	list_for_each_entry(sdev, &shost->__devices, siblings) {
-		if (sdev->sdev_state =3D=3D SDEV_DEL)
+		if (scsi_device_is_pseudo_dev(sdev) ||
+		    sdev->sdev_state =3D=3D SDEV_DEL)
 			continue;
 		spin_unlock_irqrestore(shost->host_lock, flags);
 		__scsi_remove_device(sdev);
 		goto restart;
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	/*
+	 * Remove the pseudo device last since it may be needed during removal
+	 * of other SCSI devices.
+	 */
+	if (shost->pseudo_sdev)
+		__scsi_remove_device(shost->pseudo_sdev);
 }
=20
+/**
+ * scsi_get_pseudo_dev() - Attach a pseudo SCSI device to a SCSI host
+ * @shost: Host that needs a pseudo SCSI device
+ *
+ * Lock status: None assumed.
+ *
+ * Returns:     The scsi_device or NULL
+ *
+ * Notes:
+ *	Attach a single scsi_device to the Scsi_Host. The primary aim for thi=
s
+ *	device is to serve as a container from which SCSI commands can be
+ *	allocated. Each SCSI command will carry a command tag allocated by th=
e
+ *	block layer. These SCSI commands can be used by the LLDD to send
+ *	internal or passthrough commands without having to manage tag allocat=
ion
+ *	inside the LLDD.
+ */
+struct scsi_device *scsi_get_pseudo_dev(struct Scsi_Host *shost)
+{
+	struct scsi_device *sdev =3D NULL;
+	struct scsi_target *starget;
+
+	guard(mutex)(&shost->scan_mutex);
+
+	if (!scsi_host_scan_allowed(shost))
+		goto out;
+
+	starget =3D scsi_alloc_target(&shost->shost_gendev, 0, shost->max_id);
+	if (!starget)
+		goto out;
+
+	sdev =3D scsi_alloc_sdev(starget, U64_MAX, NULL);
+	if (!sdev) {
+		scsi_target_reap(starget);
+		goto put_target;
+	}
+
+	sdev->borken =3D 0;
+
+put_target:
+	/* See also the get_device(dev) call in scsi_alloc_target(). */
+	put_device(&starget->dev);
+
+out:
+	return sdev;
+}
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 15ba493d2138..c37992147847 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1406,6 +1406,9 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	int error;
 	struct scsi_target *starget =3D sdev->sdev_target;
=20
+	if (WARN_ON_ONCE(scsi_device_is_pseudo_dev(sdev)))
+		return -EINVAL;
+
 	error =3D scsi_target_add(starget);
 	if (error)
 		return error;
@@ -1513,7 +1516,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
 	cancel_work_sync(&sdev->requeue_work);
=20
-	if (sdev->host->hostt->sdev_destroy)
+	if (!scsi_device_is_pseudo_dev(sdev) && sdev->host->hostt->sdev_destroy=
)
 		sdev->host->hostt->sdev_destroy(sdev);
 	transport_destroy_device(dev);
=20
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 6d6500148c4b..3846f5dfc51c 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -589,6 +589,22 @@ static inline unsigned int sdev_id(struct scsi_devic=
e *sdev)
 #define scmd_id(scmd) sdev_id((scmd)->device)
 #define scmd_channel(scmd) sdev_channel((scmd)->device)
=20
+/**
+ * scsi_device_is_pseudo_dev() - Whether a device is a pseudo SCSI devic=
e.
+ * @sdev: SCSI device to examine
+ *
+ * A pseudo SCSI device can be used to allocate SCSI commands but does n=
ot show
+ * up in sysfs. Additionally, the logical unit information in *@sdev is =
made up.
+ *
+ * This function tests the LUN number instead of comparing @sdev with
+ * @sdev->host->pseudo_sdev because this function may be called before
+ * @sdev->host->pseudo_sdev has been initialized.
+ */
+static inline bool scsi_device_is_pseudo_dev(struct scsi_device *sdev)
+{
+	return sdev->lun =3D=3D U64_MAX;
+}
+
 /*
  * checks for positions of the SCSI state machine
  */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 7b8f144ccf7d..4f945a20d198 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -721,6 +721,12 @@ struct Scsi_Host {
 	/* ldm bits */
 	struct device		shost_gendev, shost_dev;
=20
+	/*
+	 * A SCSI device structure used for sending internal commands to the
+	 * HBA. There is no corresponding logical unit inside the SCSI device.
+	 */
+	struct scsi_device *pseudo_sdev;
+
 	/*
 	 * Points to the transport data (if any) which is allocated
 	 * separately

