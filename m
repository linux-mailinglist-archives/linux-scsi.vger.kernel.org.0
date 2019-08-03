Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6943880675
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbfHCOAf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37899 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfHCOAe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so37438172pfn.5
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=INePfg+hYB0XZZdpfxRYjoB5rJIHkZ+5ZTU+FZMUUU8=;
        b=ZT1QfVT/piayo5hC2D4T2yYHp1sc0vTEgt+mCZ3KLTEYhQ1n8vOatXEZwKpF0OGRv5
         werkjq5w+uu+9yb+u9HP8QJCyfb5eGv7JC1M33hjVgYxLLs4uHJGvf0I9KOushZWMtaX
         Q2yPS4NpGLxJd32yiKCbjfNhqjzTaPf9z/c4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=INePfg+hYB0XZZdpfxRYjoB5rJIHkZ+5ZTU+FZMUUU8=;
        b=nH43NXHVjV/b7b8ydLQMTQc+DWCbeTbQbWr/dry8DH1veWCR/t+ab3P+PP3i/KSTvY
         sR0ka7fjx6UONNzvUb1e5dgmu6Qog00cdqVVJ609ytyYkpWYWuvd6kIhhCRbFD0D71ea
         ntyYimUZsYwEoPQt1YC7CfOZNmoUXpK7HOMq50oqak7OE9ROQBADohUjkYRgz6Lxaeb7
         hfUgxXR8cu7kliV5CRbsis0Qp9DSQnXosT0pxKHmoocEklYjyCcEShz3mrYtWIOH8F1m
         3yv/gEntZGayUDi/xUtureZd0kmB4TrIc0q+EWpMdwwjWRu+MLTcARw7sYhaQFOyqVTd
         Jt1Q==
X-Gm-Message-State: APjAAAWJjXHBMG2DJ/RV9h8bow1mtghuvvng4XARm+NvSegJt7pk4MI0
        UskCYKNNQPYiCBRtTWZYy40TnYsw4i4AKzmjmhUL3TRhuqTXoJzv7WhT8Z1dip4sKM3OszZAMUD
        fPRGOdDewcP2yz3GHP2psMMcQnCWwW0TqmTsrpZg+DjU9twtSFjKZ5iLWGy3QkNDgb/4Rvx5/mi
        eaOlos5P1Mi/CIfe5a/A==
X-Google-Smtp-Source: APXvYqzihn7Y0KCns8+LsAhIB8dBQ+Atkus//ogt+rWCkPPcR2dHQOxaKtnk/WIqNw9TCEe68sZeFg==
X-Received: by 2002:a63:c84d:: with SMTP id l13mr123933226pgi.154.1564840833838;
        Sat, 03 Aug 2019 07:00:33 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:33 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 10/12] mpt3sas: Reduce the performance dip
Date:   Sat,  3 Aug 2019 09:59:55 -0400
Message-Id: <1564840797-5876-11-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch is to reduce the performance dip depth
observed on SATA HDD when ATA PT command is outstanding.

Driver returns IO commands with status "SAM_STAT_BUSY" whenever
ATA PT command is outstanding. With this, IO commands will be
retried until this outstanding ATA PT to complete and hence we
will observe dip in performance.

As the driver is completing the subsequent IOs commands with
SAM_STAT_BUSY status, these IOs has to go though the block layer.
Hence it adds latency to the IOs and large performance
dip depth is observed.

So to reduce this performance dip depth, added improvement in
driver to return the subsequent IOs with SCSI_MLQUEUE_DEVICE_BUSY
status instead of completing the IOs with SAM_STAT_BUSY status
when ATA PT command is outstanding. Sending command back with
SCSI_MLQUEUE_DEVICE_BUSY does not go through complete block
layer stack (as scsi_done won't be called) SML immediately
push the command and this method will avoid latency of Block
layer stack and the performance dip depth will be reduced.


On Local setup, ran 512k sequential read IO operation on
HGST SATA drive with existing driver & with this improvement
drivers and here is the result,

1. With existing driver: IOs are running at bandwidth of
~230 rMB/s and whenever any ATA PT command is outstanding
(e.g issued from systemd-udevd daemon) then this bandwidth drops
to ~150 rMB/s.

2. With this improvement driver: IOs are running at bandwidth of
~230 rMB/s and whenever any ATA PT command is outstanding 
then this bandwidth drops to just ~190 rMB/s.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 9b89fa4..24b5f5f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4670,11 +4670,8 @@ scsih_qcmd(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
 	 * since we're lockless at this point
 	 */
 	do {
-		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
-			scmd->result = SAM_STAT_BUSY;
-			scmd->scsi_done(scmd);
-			return 0;
-		}
+		if (test_bit(0, &sas_device_priv_data->ata_command_pending))
+			return SCSI_MLQUEUE_DEVICE_BUSY;
 	} while (_scsih_set_satl_pending(scmd, true));
 
 	if (scmd->sc_data_direction == DMA_FROM_DEVICE)
-- 
1.8.3.1

