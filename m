Return-Path: <linux-scsi+bounces-8631-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6298E442
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Oct 2024 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67971F23549
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Oct 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162B1D278D;
	Wed,  2 Oct 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="c+8jNPK+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC859217311
	for <linux-scsi@vger.kernel.org>; Wed,  2 Oct 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901454; cv=none; b=asHeTxt6pQZlHfZEJ8Fplbggi0/g3HHK+pokTdQsEOcqdc7VKVeCdD97WOdKS/jfhfyH5ecB/efoK42WPSpYWOKw8eUBQJYf131gvd762W7SwadRRIwlVAAayzEFBHM35ZLD8wCbcxnOH6CY3mwQyEPzZi+Sh/7hov+dhghCuOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901454; c=relaxed/simple;
	bh=nQDyX/T4WoLjTuuuecubjQFu1zobeceqGNCVJpNPsXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIiVwPTh5KGKe2+ACAbwD9H3jnzhnZRRzihm+a/3GfW9nBCPP73lfj8MJzOA2i4knDh72+QVkXua0VZOn/9UekrensA9BzJpsazHrSPzYpZKTmQqu7K9+WZGb0jYeCJH9IiNYxVqsuqfAWEleGJuxyH9i8iGvxUFT7SxLfpU/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=c+8jNPK+; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XJmp447Z7zlgMW9;
	Wed,  2 Oct 2024 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727901447; x=1730493448; bh=DxPZv
	BsOKAmZV+18q53mmDtkfHqrUNijWaCEwXHAcuY=; b=c+8jNPK+Q1X+MWLW67GnI
	jvh7Q69TNoUmBkum4Ix1X+NxFwju/gTAvnYP4KG9DFSULkPXiumRBX4C5QQIKwPj
	2KOYMvVdRtMnaSe9mg7qbmdYaYxQYTOLdK7bY518B0JId1ukyD357s+WTmlsg4N+
	uxI5g/phsYtYtpDhqJKI5VAHNUC16netK0ImmyCId29mubGuCGF9P1KFEHi2u5+6
	SVlRuKRaQyqK0ftgbJB+f+vwokql4zGn8LBckFJI/ubD4xvz2OZV/s4ew8OSagNT
	g95hrtX9aFJyeQdH9MWQBdZtT8b88wCP2VSJl7rvDrntsEg9C7RqabN4Jy64kckN
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qVMMuP603WBX; Wed,  2 Oct 2024 20:37:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XJmnk0cRQzlgMWQ;
	Wed,  2 Oct 2024 20:37:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 11/11] scsi: core: Update .slave_configure() references in the documentation
Date: Wed,  2 Oct 2024 13:34:03 -0700
Message-ID: <20241002203528.4104996-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002203528.4104996-1-bvanassche@acm.org>
References: <20241002203528.4104996-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that .slave_configure() support has been removed, change all referenc=
es
to .slave_configure() into .device_configure() in the SCSI documentation.

Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/scsi/scsi_mid_low_api.rst | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi=
/scsi_mid_low_api.rst
index aba832d590eb..9addae8caf0f 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -150,10 +150,10 @@ scsi devices of which only the first 2 respond::
     scsi_scan_host()  -------+
 			    |
 			sdev_prep()
-			slave_configure() -->  scsi_change_queue_depth()
+			sdev_configure() -->  scsi_change_queue_depth()
 			    |
 			sdev_prep()
-			slave_configure()
+			sdev_configure()
 			    |
 			sdev_prep()   ***
 			sdev_destroy() ***
@@ -163,7 +163,7 @@ scsi devices of which only the first 2 respond::
 	respond, a sdev_prep(), sdev_destroy() pair is called.
=20
 If the LLD wants to adjust the default queue settings, it can invoke
-scsi_change_queue_depth() in its slave_configure() routine.
+scsi_change_queue_depth() in its sdev_configure() routine.
=20
 When an HBA is being removed it could be as part of an orderly shutdown
 associated with the LLD module being unloaded (e.g. with the "rmmod"
@@ -203,7 +203,7 @@ An LLD can use this sequence to make the mid level aw=
are of a SCSI device::
     scsi_add_device()  ------+
 			    |
 			sdev_prep()
-			slave_configure()   [--> scsi_change_queue_depth()]
+			sdev_configure()   [--> scsi_change_queue_depth()]
=20
 In a similar fashion, an LLD may become aware that a SCSI device has bee=
n
 removed (unplugged) or the connection to it has been interrupted. Some
@@ -222,7 +222,7 @@ upper layers with this sequence::
=20
 It may be useful for an LLD to keep track of struct scsi_device instance=
s
 (a pointer is passed as the parameter to sdev_prep() and
-slave_configure() callbacks). Such instances are "owned" by the mid-leve=
l.
+sdev_configure() callbacks). Such instances are "owned" by the mid-level=
.
 struct scsi_device instances are freed after sdev_destroy().
=20
=20
@@ -331,7 +331,7 @@ Details::
     *      bus scan when an HBA is added (i.e. scsi_scan_host()). So it
     *      should only be called if the HBA becomes aware of a new scsi
     *      device (lu) after scsi_scan_host() has completed. If successf=
ul
-    *      this call can lead to sdev_prep() and slave_configure() callb=
acks
+    *      this call can lead to sdev_prep() and sdev_configure() callba=
cks
     *      into the LLD.
     *
     *      Defined in: drivers/scsi/scsi_scan.c
@@ -374,7 +374,7 @@ Details::
     *      Might block: no
     *
     *      Notes: Can be invoked any time on a SCSI device controlled by=
 this
-    *      LLD. [Specifically during and after slave_configure() and pri=
or to
+    *      LLD. [Specifically during and after sdev_configure() and prio=
r to
     *      sdev_destroy().] Can safely be invoked from interrupt code.
     *
     *      Defined in: drivers/scsi/scsi.c [see source code for more not=
es]
@@ -627,14 +627,14 @@ Interface functions are supplied (defined) by LLDs =
and their function
 pointers are placed in an instance of struct scsi_host_template which
 is passed to scsi_host_alloc() [or scsi_register() / init_this_scsi_driv=
er()].
 Some are mandatory. Interface functions should be declared static. The
-accepted convention is that driver "xyz" will declare its slave_configur=
e()
+accepted convention is that driver "xyz" will declare its sdev_configure=
()
 function as::
=20
-    static int xyz_slave_configure(struct scsi_device * sdev);
+    static int xyz_sdev_configure(struct scsi_device * sdev);
=20
 and so forth for all interface functions listed below.
=20
-A pointer to this function should be placed in the 'slave_configure' mem=
ber
+A pointer to this function should be placed in the 'sdev_configure' memb=
er
 of a "struct scsi_host_template" instance. A pointer to such an instance
 should be passed to the mid level's scsi_host_alloc() [or scsi_register(=
) /
 init_this_scsi_driver()].
@@ -658,7 +658,7 @@ Summary:
   - proc_info - supports /proc/scsi/{driver_name}/{host_no}
   - queuecommand - queue scsi command, invoke 'done' on completion
   - sdev_prep - prior to any commands being sent to a new device
-  - slave_configure - driver fine tuning for given device after attach
+  - sdev_configure - driver fine tuning for given device after attach
   - sdev_destroy - given device is about to be shut down
=20
=20
@@ -975,7 +975,7 @@ Details::
     *      prior to its initial scan. The corresponding scsi device may =
not
     *      exist but the mid level is just about to scan for it (i.e. se=
nd
     *      and INQUIRY command plus ...). If a device is found then
-    *      slave_configure() will be called while if a device is not fou=
nd
+    *      sdev_configure() will be called while if a device is not foun=
d
     *      sdev_destroy() is called.
     *      For more details see the include/scsi/scsi_host.h file.
     *
@@ -985,7 +985,7 @@ Details::
=20
=20
     /**
-    *      slave_configure - driver fine tuning for given device just af=
ter it
+    *      sdev_configure - driver fine tuning for given device just aft=
er it
     *                     has been first scanned (i.e. it responded to a=
n
     *                     INQUIRY)
     *      @sdp: device that has just been attached
@@ -1004,7 +1004,7 @@ Details::
     *
     *      Optionally defined in: LLD
     **/
-	int slave_configure(struct scsi_device *sdp)
+	int sdev_configure(struct scsi_device *sdp)
=20
=20
     /**
@@ -1024,7 +1024,7 @@ Details::
     *      commands will be sent for this sdp instance. [However the dev=
ice
     *      could be re-attached in the future in which case a new instan=
ce
     *      of struct scsi_device would be supplied by future sdev_prep()
-    *      and slave_configure() calls.]
+    *      and sdev_configure() calls.]
     *
     *      Optionally defined in: LLD
     **/

