Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2D2BFEA3
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Nov 2020 04:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgKWDSL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 22 Nov 2020 22:18:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40991 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgKWDSK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 22 Nov 2020 22:18:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id t8so13578410pfg.8;
        Sun, 22 Nov 2020 19:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5c97BL1YfxE2D+K6Xbn5+xM72eGvrFC/eqxzFt88C8=;
        b=AO1A3q3Z+W/2oRs3LA2WXyjflMgvyINbZtlmIBJI4XYa4gHgiZZt/4GlMgPHR1kFAa
         f/bSHlbuw9XPJBogS3/uGioIcysms2Wtc5K2GiJlUUPWz14IDSxMeBFV7QJTGU71WUk3
         RVaCCqD4wvYJK1VUUHTZSwFuLinTsuROo50lsy4YVLZr9x+LRPMy9TRqv1Ith9NKuubl
         w/qn52sZiWM+Oj+TaR9aiWVFgJ5EQki0PvS7AVxmuzlfGAqQBkcqbTP0rtOO1+vmDwlx
         j1R0wejxx6jK3P3KvzMZw4sObyiKRXQGMMNSZXU+vU0fWp9iCpe0rEeTOv4e3uCEhGvu
         LkZA==
X-Gm-Message-State: AOAM530Gc89ZDfPo9suYmAADW9fQ+ED5Czv7G3Li+wJOdORtfPyJufgb
        S25nN2KIKN2UbihxdtcBsyU=
X-Google-Smtp-Source: ABdhPJw+F4lLe1kxm6I2PpKyxgD5+PzXRCv9gCg4NwRWXvVG/5XbhomIGos+P6jBAyIkRRswK249jw==
X-Received: by 2002:a17:90a:fed:: with SMTP id 100mr23683549pjz.65.1606101489682;
        Sun, 22 Nov 2020 19:18:09 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w12sm3578751pfn.136.2020.11.22.19.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:18:08 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stan Johnson <userm57@yahoo.com>
Subject: [PATCH v3 6/9] scsi_transport_spi: Make spi_execute() accept a request queue pointer
Date:   Sun, 22 Nov 2020 19:17:46 -0800
Message-Id: <20201123031749.14912-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123031749.14912-1-bvanassche@acm.org>
References: <20201123031749.14912-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Passing a request queue pointer to spi_execute() instead of a SCSI device
pointer will allow a later patch to associate two request queues with a
SCSI device. Additionally, instead of assuming that the device state is
SDEV_QUIESCE before domain validation starts, read the device state. This
patch does not change any functionality but makes a later patch easier to
read.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Woody Suwalski <terraluna977@gmail.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_transport_spi.c | 69 ++++++++++++++++---------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index f3d5b1bbd5aa..959990f66865 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -104,7 +104,7 @@ static int sprint_frac(char *dest, int value, int denom)
 	return result;
 }
 
-static int spi_execute(struct scsi_device *sdev, const void *cmd,
+static int spi_execute(struct request_queue *q, const void *cmd,
 		       enum dma_data_direction dir,
 		       void *buffer, unsigned bufflen,
 		       struct scsi_sense_hdr *sshdr)
@@ -117,7 +117,7 @@ static int spi_execute(struct scsi_device *sdev, const void *cmd,
 		sshdr = &sshdr_tmp;
 
 	for(i = 0; i < DV_RETRIES; i++) {
-		result = scsi_execute(sdev, cmd, dir, buffer, bufflen, sense,
+		result = __scsi_execute(q, cmd, dir, buffer, bufflen, sense,
 				      sshdr, DV_TIMEOUT, /* retries */ 1,
 				      REQ_FAILFAST_DEV |
 				      REQ_FAILFAST_TRANSPORT |
@@ -620,13 +620,14 @@ enum spi_compare_returns {
 /* This is for read/write Domain Validation:  If the device supports
  * an echo buffer, we do read/write tests to it */
 static enum spi_compare_returns
-spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
-			  u8 *ptr, const int retries)
+spi_dv_device_echo_buffer(struct scsi_device *sdev, struct request_queue *q,
+			  u8 *buffer, u8 *ptr, const int retries)
 {
 	int len = ptr - buffer;
 	int j, k, r, result;
 	unsigned int pattern = 0x0000ffff;
 	struct scsi_sense_hdr sshdr;
+	enum scsi_device_state sdev_state = sdev->sdev_state;
 
 	const char spi_write_buffer[] = {
 		WRITE_BUFFER, 0x0a, 0, 0, 0, 0, 0, len >> 8, len & 0xff, 0
@@ -671,11 +672,10 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 	}
 
 	for (r = 0; r < retries; r++) {
-		result = spi_execute(sdev, spi_write_buffer, DMA_TO_DEVICE,
+		result = spi_execute(q, spi_write_buffer, DMA_TO_DEVICE,
 				     buffer, len, &sshdr);
 		if(result || !scsi_device_online(sdev)) {
-
-			scsi_device_set_state(sdev, SDEV_QUIESCE);
+			scsi_device_set_state(sdev, sdev_state);
 			if (scsi_sense_valid(&sshdr)
 			    && sshdr.sense_key == ILLEGAL_REQUEST
 			    /* INVALID FIELD IN CDB */
@@ -693,9 +693,9 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 		}
 
 		memset(ptr, 0, len);
-		spi_execute(sdev, spi_read_buffer, DMA_FROM_DEVICE,
-			    ptr, len, NULL);
-		scsi_device_set_state(sdev, SDEV_QUIESCE);
+		spi_execute(q, spi_read_buffer, DMA_FROM_DEVICE, ptr, len,
+			    NULL);
+		scsi_device_set_state(sdev, sdev_state);
 
 		if (memcmp(buffer, ptr, len) != 0)
 			return SPI_COMPARE_FAILURE;
@@ -706,11 +706,12 @@ spi_dv_device_echo_buffer(struct scsi_device *sdev, u8 *buffer,
 /* This is for the simplest form of Domain Validation: a read test
  * on the inquiry data from the device */
 static enum spi_compare_returns
-spi_dv_device_compare_inquiry(struct scsi_device *sdev, u8 *buffer,
-			      u8 *ptr, const int retries)
+spi_dv_device_compare_inquiry(struct scsi_device *sdev, struct request_queue *q,
+			      u8 *buffer, u8 *ptr, const int retries)
 {
 	int r, result;
 	const int len = sdev->inquiry_len;
+	enum scsi_device_state sdev_state = sdev->sdev_state;
 	const char spi_inquiry[] = {
 		INQUIRY, 0, 0, 0, len, 0
 	};
@@ -718,11 +719,11 @@ spi_dv_device_compare_inquiry(struct scsi_device *sdev, u8 *buffer,
 	for (r = 0; r < retries; r++) {
 		memset(ptr, 0, len);
 
-		result = spi_execute(sdev, spi_inquiry, DMA_FROM_DEVICE,
-				     ptr, len, NULL);
+		result = spi_execute(q, spi_inquiry, DMA_FROM_DEVICE, ptr, len,
+				     NULL);
 		
 		if(result || !scsi_device_online(sdev)) {
-			scsi_device_set_state(sdev, SDEV_QUIESCE);
+			scsi_device_set_state(sdev, sdev_state);
 			return SPI_COMPARE_FAILURE;
 		}
 
@@ -742,9 +743,10 @@ spi_dv_device_compare_inquiry(struct scsi_device *sdev, u8 *buffer,
 }
 
 static enum spi_compare_returns
-spi_dv_retrain(struct scsi_device *sdev, u8 *buffer, u8 *ptr,
-	       enum spi_compare_returns 
-	       (*compare_fn)(struct scsi_device *, u8 *, u8 *, int))
+spi_dv_retrain(struct scsi_device *sdev, struct request_queue *q, u8 *buffer,
+	       u8 *ptr, enum spi_compare_returns
+	       (*compare_fn)(struct scsi_device *, struct request_queue *,
+			     u8 *, u8 *, int))
 {
 	struct spi_internal *i = to_spi_internal(sdev->host->transportt);
 	struct scsi_target *starget = sdev->sdev_target;
@@ -754,7 +756,7 @@ spi_dv_retrain(struct scsi_device *sdev, u8 *buffer, u8 *ptr,
 
 	for (;;) {
 		int newperiod;
-		retval = compare_fn(sdev, buffer, ptr, DV_LOOPS);
+		retval = compare_fn(sdev, q, buffer, ptr, DV_LOOPS);
 
 		if (retval == SPI_COMPARE_SUCCESS
 		    || retval == SPI_COMPARE_SKIP_TEST)
@@ -800,7 +802,8 @@ spi_dv_retrain(struct scsi_device *sdev, u8 *buffer, u8 *ptr,
 }
 
 static int
-spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
+spi_dv_device_get_echo_buffer(struct scsi_device *sdev,
+			      struct request_queue *q, u8 *buffer)
 {
 	int l, result;
 
@@ -824,8 +827,8 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 	 * (reservation conflict, device not ready, etc) just
 	 * skip the write tests */
 	for (l = 0; ; l++) {
-		result = spi_execute(sdev, spi_test_unit_ready, DMA_NONE, 
-				     NULL, 0, NULL);
+		result = spi_execute(q, spi_test_unit_ready, DMA_NONE, NULL, 0,
+				     NULL);
 
 		if(result) {
 			if(l >= 3)
@@ -836,8 +839,8 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 		}
 	}
 
-	result = spi_execute(sdev, spi_read_buffer_descriptor, 
-			     DMA_FROM_DEVICE, buffer, 4, NULL);
+	result = spi_execute(q, spi_read_buffer_descriptor, DMA_FROM_DEVICE,
+			     buffer, 4, NULL);
 
 	if (result)
 		/* Device has no echo buffer */
@@ -847,7 +850,8 @@ spi_dv_device_get_echo_buffer(struct scsi_device *sdev, u8 *buffer)
 }
 
 static void
-spi_dv_device_internal(struct scsi_device *sdev, u8 *buffer)
+spi_dv_device_internal(struct scsi_device *sdev, struct request_queue *q,
+		       u8 *buffer)
 {
 	struct spi_internal *i = to_spi_internal(sdev->host->transportt);
 	struct scsi_target *starget = sdev->sdev_target;
@@ -859,7 +863,7 @@ spi_dv_device_internal(struct scsi_device *sdev, u8 *buffer)
 	DV_SET(offset, 0);
 	DV_SET(width, 0);
 
-	if (spi_dv_device_compare_inquiry(sdev, buffer, buffer, DV_LOOPS)
+	if (spi_dv_device_compare_inquiry(sdev, q, buffer, buffer, DV_LOOPS)
 	    != SPI_COMPARE_SUCCESS) {
 		starget_printk(KERN_ERR, starget, "Domain Validation Initial Inquiry Failed\n");
 		/* FIXME: should probably offline the device here? */
@@ -875,9 +879,8 @@ spi_dv_device_internal(struct scsi_device *sdev, u8 *buffer)
 	if (i->f->set_width && max_width) {
 		i->f->set_width(starget, 1);
 
-		if (spi_dv_device_compare_inquiry(sdev, buffer,
-						   buffer + len,
-						   DV_LOOPS)
+		if (spi_dv_device_compare_inquiry(sdev, q, buffer, buffer + len,
+						  DV_LOOPS)
 		    != SPI_COMPARE_SUCCESS) {
 			starget_printk(KERN_ERR, starget, "Wide Transfers Fail\n");
 			i->f->set_width(starget, 0);
@@ -946,7 +949,7 @@ spi_dv_device_internal(struct scsi_device *sdev, u8 *buffer)
 	DV_SET(width, max_width);
 
 	/* Do the read only INQUIRY tests */
-	spi_dv_retrain(sdev, buffer, buffer + sdev->inquiry_len,
+	spi_dv_retrain(sdev, q, buffer, buffer + sdev->inquiry_len,
 		       spi_dv_device_compare_inquiry);
 	/* See if we actually managed to negotiate and sustain DT */
 	if (i->f->get_dt)
@@ -958,7 +961,7 @@ spi_dv_device_internal(struct scsi_device *sdev, u8 *buffer)
 	 * negotiated DT */
 
 	if (len == -1 && spi_dt(starget))
-		len = spi_dv_device_get_echo_buffer(sdev, buffer);
+		len = spi_dv_device_get_echo_buffer(sdev, q, buffer);
 
 	if (len <= 0) {
 		starget_printk(KERN_INFO, starget, "Domain Validation skipping write tests\n");
@@ -970,7 +973,7 @@ spi_dv_device_internal(struct scsi_device *sdev, u8 *buffer)
 		len = SPI_MAX_ECHO_BUFFER_SIZE;
 	}
 
-	if (spi_dv_retrain(sdev, buffer, buffer + len,
+	if (spi_dv_retrain(sdev, q, buffer, buffer + len,
 			   spi_dv_device_echo_buffer)
 	    == SPI_COMPARE_SKIP_TEST) {
 		/* OK, the stupid drive can't do a write echo buffer
@@ -1030,7 +1033,7 @@ spi_dv_device(struct scsi_device *sdev)
 
 	starget_printk(KERN_INFO, starget, "Beginning Domain Validation\n");
 
-	spi_dv_device_internal(sdev, buffer);
+	spi_dv_device_internal(sdev, sdev->request_queue, buffer);
 
 	starget_printk(KERN_INFO, starget, "Ending Domain Validation\n");
 
