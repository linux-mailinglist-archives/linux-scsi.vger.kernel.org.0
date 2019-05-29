Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E12E624
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE2U26 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44925 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2U26 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so2350100pfo.11
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0PGFA1tM2gvAM5Ii35v+ql0oQ1wLLyeQtURDwvOv6Y=;
        b=UmKoOisEzOWnBK8nteLmnLHX0HyvdN/KCMGXNDZhBFmybIs0O5gqPspeQ+KZisp6hi
         f2FQzDMcJcbFHQuUo5w7/SCR89dI46i5uCvLXOS8JfE6Z7LRrW6t2Sl9vtHccGQvDDr+
         cA2BnuOP6K8o/1jM/XgbKJtCkNm4Fd45Gbjb+Xz+wfcQKUqB8A5BdzFvoajgvDdwp07t
         KK7Row967jllE+u82wQv/gGUM8IkDUONNKUyuR3VR4PIA+KgFgdeqyF/31cujdWzfGf8
         +UIpzu5o/p7Zh4hYMrKlBmrhI3nu8n5+Isecmtap5aeDEvCzIibZ+kh4RiF6mLmcCu97
         pr6A==
X-Gm-Message-State: APjAAAW21D1PNAYH+1gAkJLGth0BuBSantiH+OFNDlzAzJcBXnQDCNYW
        lWzld8sp2RwzNIzsvQzUCrc=
X-Google-Smtp-Source: APXvYqw9fbOv47Vnp/ZMD7UUyJw5tnFolutMJRaL13zocHRqO8z+gTlztfo1W2iJUoZgy1PGkQp0cg==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr125324184pfn.92.1559161737371;
        Wed, 29 May 2019 13:28:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 16/20] qla2xxx: Remove a superfluous pointer check
Date:   Wed, 29 May 2019 13:28:22 -0700
Message-Id: <20190529202826.204499-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Checking a pointer after it has been dereferenced is not useful. This was
detected by Coverity.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 7b8ed44874fc..021071e7f4ad 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -188,7 +188,7 @@ static void qla_nvme_abort_work(struct work_struct *work)
 	       "%s called for sp=%p, hndl=%x on fcport=%p deleted=%d\n",
 	       __func__, sp, sp->handle, fcport, fcport->deleted);
 
-	if (!ha->flags.fw_started && (fcport && fcport->deleted))
+	if (!ha->flags.fw_started && fcport->deleted)
 		return;
 
 	if (ha->flags.host_shutting_down) {
-- 
2.22.0.rc1

