Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECC12F152
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jan 2020 23:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgABW7k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jan 2020 17:59:40 -0500
Received: from authsmtp03.register.it ([81.88.48.53]:39121 "EHLO
        authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727409AbgABWN5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Jan 2020 17:13:57 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 17:13:55 EST
Received: from [192.168.1.1] ([93.41.32.9])
        by cmsmtp with ESMTPSA
        id n8b9ir9UONsF7n8b9iIhju; Thu, 02 Jan 2020 23:05:43 +0100
X-Rid:  guido@trentalancia.com@93.41.32.9
Message-ID: <1578002742.5239.0.camel@trentalancia.com>
Subject: [PATCH RESEND v2] scsi: ignore Synchronize Cache command failures
 to keep using drives not supporting it
From:   Guido Trentalancia <guido@trentalancia.com>
To:     linux-scsi@vger.kernel.org
Date:   Thu, 02 Jan 2020 23:05:42 +0100
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPgX4JmffzOxSPLNZSjriTpfYy85Mj9vtPFI/FL/a90X78EhvTYpbE+O5cCCA7AcF3UKvsZ/uA9nvCIhGsIhQo3ArL6KH4rYsCPAkfogEtwuK3DPk3rM
 EyJW3QxLATAMTpj+GPaFw6ALQE5reIQtpRGraLnuIXip0IUbQmz+jvWC75xdS5fbIz869MXtanGcSg==
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Many obsolete hard drives do not support the Synchronize Cache SCSI
command. Such command is generally issued during fsync() calls which
at the moment therefore fail with the ILLEGAL_REQUEST sense key.

Since this failure is currently treated as critical in the kernel SCSI
disk driver, such obsolete hard drives cannot be used anymore: they
cannot be formatted, mounted and/or checked using tools such as e2fsprogs.

Because there is nothing which can be done if the drive does not support
such command, such ILLEGAL_REQUEST should be treated as non-critical so
that the underlying operation does not fail and the obsolete hard drive
can be used normally.

This patch disables the Write Cache feature as a precaution on hard
drives which do not support the Synchronize Cache command and therefore
the cache flushing functionality.

Fixes bug: https://bugzilla.kernel.org/show_bug.cgi?id=203635

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 drivers/scsi/sd.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff -pru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	2019-03-17 18:22:04.822720851 +0100
+++ b/drivers/scsi/sd.c	2019-03-20 17:41:44.526957307 +0100
@@ -22,6 +22,10 @@
  *	 - Badari Pulavarty <pbadari@us.ibm.com>, Matthew Wilcox 
  *	   <willy@debian.org>, Kurt Garloff <garloff@suse.de>: 
  *	   Support 32k/1M disks.
+ *	 - Guido Trentalancia <guido@trentalancia.com> ignore Synchronize
+ *	   Cache command failures on hard-drives that do not support it
+ *	   and disable the Write Cache functionality on such devices as a
+ *	   precaution: this allows to keep using several obsolete drives.
  *
  *	Logging policy (needs CONFIG_SCSI_LOGGING defined):
  *	 - setting up transfer: SCSI_LOG_HLQUEUE levels 1 and 2
@@ -1633,6 +1637,20 @@ static int sd_sync_cache(struct scsi_dis
 	}
 
 	if (res) {
+		/*
+		 * sshdr.sense_key == ILLEGAL_REQUEST means this drive
+		 * doesn't support sync. There's not much to do and
+		 * sync shouldn't fail.
+		 */
+		if (sshdr->sense_key == ILLEGAL_REQUEST && sshdr->asc == 0x20) {
+			if (sdkp->WCE) {
+				sdkp->WCE = 0;
+				sd_printk(KERN_NOTICE, sdkp, "Drive does not support Synchronize Cache(10) command: disabling write cache.\n");
+				sd_set_flush_flag(sdkp);
+			}
+			return 0;
+		}
+
 		sd_print_result(sdkp, "Synchronize Cache(10) failed", res);
 
 		if (driver_byte(res) == DRIVER_SENSE)
@@ -2022,6 +2040,17 @@ static int sd_done(struct scsi_cmnd *SCp
 					req->rq_flags |= RQF_QUIET;
 				}
 				break;
+			case SYNCHRONIZE_CACHE:
+				if (sshdr.asc == 0x20) {
+					if (sdkp->WCE) {
+						sdkp->WCE = 0;
+						sd_printk(KERN_NOTICE, sdkp, "Drive does not support Synchronize Cache(10) command: disabling write cache.\n");
+						sd_set_flush_flag(sdkp);
+					}
+					SCpnt->result = 0;
+					good_bytes = scsi_bufflen(SCpnt);
+				}
+				break;
 			}
 		}
 		break;
