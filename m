Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3304081F7
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Sep 2021 23:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhILV7O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Sep 2021 17:59:14 -0400
Received: from tartarus.angband.pl ([51.83.246.204]:39916 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbhILV7N (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 12 Sep 2021 17:59:13 -0400
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mPX5H-00C2fO-8T; Sun, 12 Sep 2021 23:32:21 +0200
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mPX5G-0003DO-Gb; Sun, 12 Sep 2021 23:32:18 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95-RC2)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1mPX5D-0003Aa-Ao;
        Sun, 12 Sep 2021 23:32:15 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Sun, 12 Sep 2021 23:32:10 +0200
Message-Id: <20210912213212.12169-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001,SPF_PASS=-0.001,TVD_RCVD_IP=0.001 autolearn=no
        autolearn_force=no languages=en
Subject: [PATCH 1/3] scsi: aic7xxx: fix building with -Werror (missing include)
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This is an userland helper tool to generate data rather than something
compiled into the kernel, thus it wants regular POSIX functions.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
index 975fcfcc0d8f..2cd87ea86dfc 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
@@ -45,6 +45,7 @@
 #include <sys/types.h>
 
 #include "aicdb.h"
+#include <ctype.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <regex.h>
-- 
2.33.0

