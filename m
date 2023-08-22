Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24A784592
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Aug 2023 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjHVPbO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Aug 2023 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjHVPbO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Aug 2023 11:31:14 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482A5CE7
        for <linux-scsi@vger.kernel.org>; Tue, 22 Aug 2023 08:31:10 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-34c9f8c9876so10822115ab.3
        for <linux-scsi@vger.kernel.org>; Tue, 22 Aug 2023 08:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718269; x=1693323069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Gdk4CuSFOEhAJXwsAU/ygf8gmkeoSfjq3T8qNuvsWI=;
        b=H0tNdxKyR9uzazdpRkgV6d3aYvwVdJaM+GU6emIHHB6NaEbvMtQwkakF3pOMM8saZF
         tnJ5a688eeaaO+efOHA4iL6plvwWL1oORdF1EatJA1z48A0Zxhxv9O5STPBN/G0U+0KY
         IgtlIz9gsB7Xr7K5iMVT7v+iSG2EXQLQ3UNQ2FMPtLAMqjKzln1b4i8YOqn4ryBmWH78
         ZqgRCHqkYL3hvwXArbzlYzpoVmqaFooiEOflVb6tPqlBZzu1QMfo1NYPY+K8AnR6G5ji
         HkaiYIxKMCgDXT8pMcjSmJiRdUOwYIb5odNsPVdGy1z8Yx4YD4zZLvzY68yHgi/bX4vs
         XKkQ==
X-Gm-Message-State: AOJu0Yz0TPa2H9c8YnuF70e9Izx0J6skuXxUWroDjSXN5CXThuTvj5c9
        yNdu29UaH+xdm91gio/GrZ4=
X-Google-Smtp-Source: AGHT+IErKIFIa7O8pnTroLn8/Qd8MEwMVizx324tx9TJ8RWoYslEFCoVAhTz9rinNfNhrwNgEkc1MA==
X-Received: by 2002:a05:6e02:1bc5:b0:34c:a244:bb9c with SMTP id x5-20020a056e021bc500b0034ca244bb9cmr11472076ilv.21.1692718269321;
        Tue, 22 Aug 2023 08:31:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:88be:bf57:de29:7cc])
        by smtp.gmail.com with ESMTPSA id p15-20020a637f4f000000b00563590be25esm8197556pgn.29.2023.08.22.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:31:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.g.garry@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Don Brace <don.brace@microchip.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2] scsi: core: Improve type safety of scsi_rescan_device()
Date:   Tue, 22 Aug 2023 08:30:41 -0700
Message-ID: <20230822153043.4046244-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Most callers of scsi_rescan_device() have the scsi_device pointer readily
available. Pass a struct scsi_device pointer to scsi_rescan_device()
instead of a struct device pointer. This change prevents that a
pointer to another struct device would be passed accidentally to
scsi_rescan_device().

Remove the scsi_rescan_device() declaration from the scsi_priv.h header
file since it duplicates the declaration in <scsi/scsi_host.h>.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1:
 - Inserted the word "readily" in the patch description.
 - Removed a redundant occurence of the word pointer from the patch description.

 drivers/ata/libata-scsi.c             | 2 +-
 drivers/scsi/aacraid/commsup.c        | 2 +-
 drivers/scsi/mvumi.c                  | 2 +-
 drivers/scsi/scsi_lib.c               | 2 +-
 drivers/scsi/scsi_priv.h              | 1 -
 drivers/scsi/scsi_scan.c              | 4 ++--
 drivers/scsi/scsi_sysfs.c             | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 drivers/scsi/storvsc_drv.c            | 2 +-
 drivers/scsi/virtio_scsi.c            | 2 +-
 include/scsi/scsi_host.h              | 2 +-
 11 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 370d18aca71e..f5c36c8c243a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4884,7 +4884,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			}
 
 			spin_unlock_irqrestore(ap->lock, flags);
-			scsi_rescan_device(&(sdev->sdev_gendev));
+			scsi_rescan_device(sdev);
 			scsi_device_put(sdev);
 			spin_lock_irqsave(ap->lock, flags);
 		}
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 3f062e4013ab..013a9a334972 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1451,7 +1451,7 @@ static void aac_handle_aif(struct aac_dev * dev, struct fib * fibptr)
 #endif
 				break;
 			}
-			scsi_rescan_device(&device->sdev_gendev);
+			scsi_rescan_device(device);
 			break;
 
 		default:
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 73aa7059b556..6cfbac518085 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1500,7 +1500,7 @@ static void mvumi_rescan_devices(struct mvumi_hba *mhba, int id)
 
 	sdev = scsi_device_lookup(mhba->shost, 0, id, 0);
 	if (sdev) {
-		scsi_rescan_device(&sdev->sdev_gendev);
+		scsi_rescan_device(sdev);
 		scsi_device_put(sdev);
 	}
 }
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d84209a96b48..b0169ffaefd2 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2445,7 +2445,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
 		envp[idx++] = "SDEV_MEDIA_CHANGE=1";
 		break;
 	case SDEV_EVT_INQUIRY_CHANGE_REPORTED:
-		scsi_rescan_device(&sdev->sdev_gendev);
+		scsi_rescan_device(sdev);
 		envp[idx++] = "SDEV_UA=INQUIRY_DATA_HAS_CHANGED";
 		break;
 	case SDEV_EVT_CAPACITY_CHANGE_REPORTED:
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index f42388ecb024..65c993c97909 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -138,7 +138,6 @@ extern int scsi_complete_async_scans(void);
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, u64, enum scsi_scan_mode);
 extern void scsi_forget_host(struct Scsi_Host *);
-extern void scsi_rescan_device(struct device *);
 
 /* scsi_sysctl.c */
 #ifdef CONFIG_SYSCTL
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index e046dd51d326..712eebceda35 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1622,9 +1622,9 @@ int scsi_add_device(struct Scsi_Host *host, uint channel,
 }
 EXPORT_SYMBOL(scsi_add_device);
 
-void scsi_rescan_device(struct device *dev)
+void scsi_rescan_device(struct scsi_device *sdev)
 {
-	struct scsi_device *sdev = to_scsi_device(dev);
+	struct device *dev = &sdev->sdev_gendev;
 
 	device_lock(dev);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 60317676e45f..24f6eefb6803 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -747,7 +747,7 @@ static ssize_t
 store_rescan_field (struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	scsi_rescan_device(dev);
+	scsi_rescan_device(to_scsi_device(dev));
 	return count;
 }
 static DEVICE_ATTR(rescan, S_IWUSR, NULL, store_rescan_field);
@@ -840,7 +840,7 @@ store_state_field(struct device *dev, struct device_attribute *attr,
 		 * waiting for pending I/O to finish.
 		 */
 		blk_mq_run_hw_queues(sdev->request_queue, true);
-		scsi_rescan_device(dev);
+		scsi_rescan_device(sdev);
 	}
 
 	return ret == 0 ? count : -EINVAL;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 6aaaa7ebca37..ed694d939964 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2257,7 +2257,7 @@ static void pqi_update_device_list(struct pqi_ctrl_info *ctrl_info,
 			device->advertised_queue_depth = device->queue_depth;
 			scsi_change_queue_depth(device->sdev, device->advertised_queue_depth);
 			if (device->rescan) {
-				scsi_rescan_device(&device->sdev->sdev_gendev);
+				scsi_rescan_device(device->sdev);
 				device->rescan = false;
 			}
 		}
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 659196a2f63a..6bfd88495edb 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -470,7 +470,7 @@ static void storvsc_device_scan(struct work_struct *work)
 	sdev = scsi_device_lookup(wrk->host, 0, wrk->tgt_id, wrk->lun);
 	if (!sdev)
 		goto done;
-	scsi_rescan_device(&sdev->sdev_gendev);
+	scsi_rescan_device(sdev);
 	scsi_device_put(sdev);
 
 done:
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bd5633667d01..9d1bdcdc1331 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -325,7 +325,7 @@ static void virtscsi_handle_param_change(struct virtio_scsi *vscsi,
 	/* Handle "Parameters changed", "Mode parameters changed", and
 	   "Capacity data has changed".  */
 	if (asc == 0x2a && (ascq == 0x00 || ascq == 0x01 || ascq == 0x09))
-		scsi_rescan_device(&sdev->sdev_gendev);
+		scsi_rescan_device(sdev);
 
 	scsi_device_put(sdev);
 }
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 70b7475dcf56..b07db65906dd 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -764,7 +764,7 @@ scsi_template_proc_dir(const struct scsi_host_template *sht);
 #define scsi_template_proc_dir(sht) NULL
 #endif
 extern void scsi_scan_host(struct Scsi_Host *);
-extern void scsi_rescan_device(struct device *);
+extern void scsi_rescan_device(struct scsi_device *);
 extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
