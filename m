Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B86708A74
	for <lists+linux-scsi@lfdr.de>; Thu, 18 May 2023 23:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjERV2K (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 May 2023 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjERV2C (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 May 2023 17:28:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3510C8;
        Thu, 18 May 2023 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gvuFFjW/caZa6pJ6UHFjmzLzAyq1dSPPy/Ju8ubQEzY=; b=vZtofMLF9mLOd1XqxZ3BuhrSwZ
        8e4sgSv8p+K2mPii6KPLB/5eslcOEa6XQ7V9p15UzaOyIoYLBBJr/hY/AC/s4F1utUykVZ/m8t0Be
        HNRHAUKd+DaOdlZ6pTBsf+xTNmjrDJVB/CI5iizRZuWjInhguxSwtjgGb2iF5HAUguCb25HI2Lu7x
        vDrCHR4AK49LhcBp0g64PmRQLMGHtXe2wtn7SxGIdO3Jo1KaZTYeLrwfvMyUhriBga503u7V5bbBr
        4CwF8borfFCC0JX9CtotY/sSTzTsFZI9ATjreH2iS/aAYbp/B0lA28yZRaVlOcVCmYfAT/s81jDJe
        xtU9DSmg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzlAD-00EFRV-2P;
        Thu, 18 May 2023 21:27:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 11/11] Docs/scsi: sym53c8xx_2: shorten chapter heading
Date:   Thu, 18 May 2023 14:27:49 -0700
Message-Id: <20230518212749.18266-12-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518212749.18266-1-rdunlap@infradead.org>
References: <20230518212749.18266-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make the chapter heading concise yet still descriptive.
This makes the subsystem table of contents more readable (IMO).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
---
 Documentation/scsi/sym53c8xx_2.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/scsi/sym53c8xx_2.rst b/Documentation/scsi/sym53c8xx_2.rst
--- a/Documentation/scsi/sym53c8xx_2.rst
+++ b/Documentation/scsi/sym53c8xx_2.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================================
-The Linux SYM-2 driver documentation file
-=========================================
+============
+SYM-2 driver
+============
 
 Written by Gerard Roudier <groudier@free.fr>
 
