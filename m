Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0327FEDB03
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDJCT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728251AbfKDJCR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40E4DB4B9;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 29/52] libiscsi: use scsi_build_sense()
Date:   Mon,  4 Nov 2019 10:01:28 +0100
Message-Id: <20191104090151.129140-30-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use scsi_build_sense() to format the sense code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/libiscsi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index ebd47c0cf9e9..9c85d7902faa 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -813,10 +813,7 @@ static void iscsi_scsi_cmd_rsp(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 
 		ascq = session->tt->check_protection(task, &sector);
 		if (ascq) {
-			sc->result = DRIVER_SENSE << 24 |
-				     SAM_STAT_CHECK_CONDITION;
-			scsi_build_sense_buffer(1, sc->sense_buffer,
-						ILLEGAL_REQUEST, 0x10, ascq);
+			scsi_build_sense(sc, 1, ILLEGAL_REQUEST, 0x10, ascq);
 			scsi_set_sense_information(sc->sense_buffer,
 						   SCSI_SENSE_BUFFERSIZE,
 						   sector);
-- 
2.16.4

