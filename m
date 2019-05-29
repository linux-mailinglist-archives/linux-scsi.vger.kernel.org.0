Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3932E615
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfE2U2k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:28:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44918 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2U2j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:28:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so539726pgp.11
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 13:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HCJMWXlHp0rIN5Lm/iwoPOcNUMhsJOAe+X6byArHno=;
        b=SQKWyFFFknZ8a2Cgnh0rILEcM4L4WsOAdDouLoCczqvExIHaW65h5JZ2dLGKGZXS/P
         IH0usnro7yyLyPwYCSGg1fI5R3gCws3d3c48THN1tlc5TSV26wzanzDj5Xn3IaJvWBaz
         ZMIG4gHxHXzUwwWlPM4L5kxXsxjW8BBGOyu+d1XKJ1G9TpwcMkz/Qmvy9eFVCVVRWxgS
         rG94TdU6Jw2U0i27hOLpO8Yhb7Sn7ZuIT8gYm128mLQ90QirogSvp/bIqYnhtN44781S
         cakEL4tX7zhQ7NV5vSFeB/m2hAgeENycU/z0mfql3GzyywEQyXDxzuGh+wchkKjJlhXn
         rEjQ==
X-Gm-Message-State: APjAAAWY91W7sx8RX6KZP0oUyqRLFV86pouCZW0vZT+iTISXltKZN4FB
        nHALzNGveEXx/KnbMZaaNok=
X-Google-Smtp-Source: APXvYqwJIxUkgeIRAAvhchCFXqSMNKfRmbFjTQejDvKOB3mGHox8rLw7Gkg6HQPsJSSiNX1Px1Gwpw==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr141775868pgs.443.1559161719287;
        Wed, 29 May 2019 13:28:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y12sm239229pgi.10.2019.05.29.13.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:28:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 01/20] qla2xxx: Include the <asm/unaligned.h> header file from qla_dsd.h
Date:   Wed, 29 May 2019 13:28:07 -0700
Message-Id: <20190529202826.204499-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
References: <20190529202826.204499-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since the put_unaligned_*() macros are used in this header file, include
the header file that defines these macros.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 15b7a68c1d03 ("scsi: qla2xxx: Introduce the dsd32 and dsd64 data structures") # v5.2-rc1.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_dsd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_dsd.h b/drivers/scsi/qla2xxx/qla_dsd.h
index 7479924ba422..20788054b91b 100644
--- a/drivers/scsi/qla2xxx/qla_dsd.h
+++ b/drivers/scsi/qla2xxx/qla_dsd.h
@@ -1,6 +1,8 @@
 #ifndef _QLA_DSD_H_
 #define _QLA_DSD_H_
 
+#include <asm/unaligned.h>
+
 /* 32-bit data segment descriptor (8 bytes) */
 struct dsd32 {
 	__le32 address;
-- 
2.22.0.rc1

