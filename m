Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC04C7E19E
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfHAR5B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43200 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id r22so7018076pgk.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jp+EGJbAoIFqmDqYR7M9BUo4OWihdpEUUFUfgggkUjo=;
        b=W1Aw/RaZA/+CxPgv3tjmZSxIQslEAKUw+vU85jqPTPoqwjLFfL5Vb8EM4bzBi/vjPw
         IuvMR12JJTuWwws/Hj8DjoKd9hWnmnwAu3vu0M86sW0y7h8ni9hE4aeKMxK5JFxke4KB
         omywpQYSbz7UaK+6tl8knZOBTr8qOj603+uoN2fNZwxphgwBNPO5pDycMd+SJlbDKm7W
         O2FoCVd7zpe244cQmF59uvGD3E7ioMHuvsTKjghIgYFO1wrkGE5woK/NvJ6a/KtAnsqH
         Po6VIVuEDQcbxlKHeKRIwqNEEE/eekieIPeTtjkE9aTDL5uIy5xGPuu0d1hLR+a+ueSh
         iH6w==
X-Gm-Message-State: APjAAAWESSE4Dm7GwWqzUFYMwt1hLtp38/eWMfw7+Q/Fa0Ni7e9CINzm
        Meo2FA5iRb8sosEj/dH7tMI=
X-Google-Smtp-Source: APXvYqzWnAgzoc4BwLcLmakJ4w18jZbJKl2VjcXpXOZ/wfScdlls8ttPMUK3a7SzCirmYy1Ulr/h+w==
X-Received: by 2002:a63:394:: with SMTP id 142mr1924594pgd.43.1564682220551;
        Thu, 01 Aug 2019 10:57:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 29/59] qla2xxx: Suppress a Coveritiy complaint about integer overflow
Date:   Thu,  1 Aug 2019 10:55:44 -0700
Message-Id: <20190801175614.73655-30-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch fixes the following Coverity complaint:

Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN)
overflow_before_widen: Potentially overflowing expression dma_eng_num *
65536U with type unsigned int (32 bits, unsigned) is evaluated using 32-bit
arithmetic, and then used in a context that expects an expression of type
uint64_t (64 bits, unsigned).

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_nx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nx2.c b/drivers/scsi/qla2xxx/qla_nx2.c
index 369ac04d0454..c056f466f1f4 100644
--- a/drivers/scsi/qla2xxx/qla_nx2.c
+++ b/drivers/scsi/qla2xxx/qla_nx2.c
@@ -2810,7 +2810,7 @@ qla8044_minidump_process_pollrdmwr(struct scsi_qla_host *vha,
 
 #define ISP8044_PEX_DMA_ENGINE_INDEX		8
 #define ISP8044_PEX_DMA_BASE_ADDRESS		0x77320000
-#define ISP8044_PEX_DMA_NUM_OFFSET		0x10000
+#define ISP8044_PEX_DMA_NUM_OFFSET		0x10000UL
 #define ISP8044_PEX_DMA_CMD_ADDR_LOW		0x0
 #define ISP8044_PEX_DMA_CMD_ADDR_HIGH		0x04
 #define ISP8044_PEX_DMA_CMD_STS_AND_CNTRL	0x08
-- 
2.22.0.770.g0f2c4a37fd-goog

