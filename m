Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1957E186
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfHAR4a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:56:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43147 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfHAR43 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:56:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so7017402pgk.10
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qpwTT966qqYxyx9RwdWotIWfLHY+LgJ50CpQg5okS4=;
        b=Kb6Bl1B6iwGL3ue+H3bnKlzlwn/GfTDrh1rvoa6ZufhtN7yDURPLOIVwrdt+nQRYEo
         SYG1ZDJ8SRbOlAu13LwpReGQYN12Ni+e418MSmV3KG450TgV+PeSjZJeJKbeE8wf5ClL
         MB9LczgqQOgAsTQjT063Phj7JdCCoXPCnX5NIaEqLqSvyfTw7m35goNE5hq0xcDQnUHA
         ioSOlomikbdx9Z8rFzYVULoZBMb6Z7/9q/SKs2ga05FT4Y5Hcz10h98nSps6lbo39chD
         4VFv/1bqVTUvuRkqXWe/wPpoePvd9Be2gg4iLBxW4r6N1AAupKTcPzT1BJ5RUtxJFClI
         x4mA==
X-Gm-Message-State: APjAAAX1QZjDAu86nB0JFut5iAPIKyIqKzbhV19BGSFZUKlm99z80UR9
        KiNaqQ0QAyCEk7Ynn88YdaU=
X-Google-Smtp-Source: APXvYqwkdZ0/A3tW9RiYMeSnYTi38hb2Xab1TI7ds7St30L1AQuKOKHdqRv94oW5xYRHXHS5V7kfdA==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr88096380pgq.415.1564682189128;
        Thu, 01 Aug 2019 10:56:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.56.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:56:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 05/59] qla2xxx: Include the <asm/unaligned.h> header file from qla_dsd.h
Date:   Thu,  1 Aug 2019 10:55:20 -0700
Message-Id: <20190801175614.73655-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
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
2.22.0.770.g0f2c4a37fd-goog

