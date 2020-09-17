Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68626E53B
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Sep 2020 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIQTQL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgIQQS2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Sep 2020 12:18:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D0C061356
        for <linux-scsi@vger.kernel.org>; Thu, 17 Sep 2020 09:00:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so1479655pfn.9
        for <linux-scsi@vger.kernel.org>; Thu, 17 Sep 2020 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyqT5DAvLDgsGMi6Y/ooNL+LKnGqQcxgtFjfUSbSM2I=;
        b=KG+/Qva/Q1GNX/h+M+3Z05dm/opPuXEiNjr7HazE0EwItZsZ8OOv8IG6xMi4FFQNCp
         2M/e1jsGLGy3oIN38Qua174krnW5M/ImiYDQddUOHoM4taUcIpbYeE/qYZn9X/REoOgk
         liREg+i1Zos0JWYqiIHXi3xMhBGnFKxt/kFGZ8tI20/fHalgGmNCy1lneex7IduU9dqY
         61E+VI9FRRJKZCGintEMsUNNC7BhaV8EeSIfKsllbQ/mqoaDKI4l3RtZWYwcKOnaejph
         Fc54jSeBKcC8ud5SDblhE6/GMkEeRcLIR4NHUH3oxuChygEZ6bCwTR2/8g+GZnUW4szj
         hqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyqT5DAvLDgsGMi6Y/ooNL+LKnGqQcxgtFjfUSbSM2I=;
        b=r66VJI0oF5mQvIOAAgGeu37By70wg8M6Ng9JzaETfIU9syrQMnOGPke2gCV4A9Kuai
         Y4BZMF/3VLXWIH53mMAW+gOHDTtyfnBIJZHYK+XjiloLB3GZL6nNz8MCD85HFPuv/plf
         6uS3XYpXHYwDjaimMc5HgosZK387PfU5r3HC6E1aViH9nVICctoBdCVttgFr9k1NzLEv
         00m26ICviz17MEGKYFL4OKnBLS/aMh0IcJPtSadBz8DCk6JyZQ2jjuADjNeTgHcCZOYI
         3kuAvk0EI+8pG4M0laNuQJtJq1bmTXf+DVXIVhGXYjIfZYYjdNnIrstDH4C444pdBsm3
         82jg==
X-Gm-Message-State: AOAM531lJwr1Pt0hRTUUgncaePmoT1pOoaS5BulPH3cyIM6Zj29nCv9h
        tOuSJqp1Yr5DO2udHbBdz5Z2Fc5bAXhfcA==
X-Google-Smtp-Source: ABdhPJzZ3pIsLWszGhwWauAcCCg6KIpW3wc/Kbzio9b9UYqDuehIEY/rA7AoZIcJvvEcL1vs4qlS0w==
X-Received: by 2002:a63:161e:: with SMTP id w30mr22504248pgl.255.1600358432695;
        Thu, 17 Sep 2020 09:00:32 -0700 (PDT)
Received: from localhost.localdomain ([161.81.44.186])
        by smtp.gmail.com with ESMTPSA id 137sm29897pfu.149.2020.09.17.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 09:00:32 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH 2/2] block/scsi_ioctl.c: use queue_logical_block_size() in max_sectors_bytes()
Date:   Fri, 18 Sep 2020 00:00:16 +0800
Message-Id: <20200917160016.2091-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917160016.2091-1-tom.ty89@gmail.com>
References: <20200917160016.2091-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Logical block size was never / is no longer necessarily 512.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 block/scsi_ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..82ed73f07460 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -73,10 +73,11 @@ static int sg_set_timeout(struct request_queue *q, int __user *p)
 static int max_sectors_bytes(struct request_queue *q)
 {
 	unsigned int max_sectors = queue_max_sectors(q);
+	max_sectors *= queue_logical_block_size(q);
 
-	max_sectors = min_t(unsigned int, max_sectors, INT_MAX >> 9);
+	max_sectors = min_t(unsigned int, max_sectors, INT_MAX);
 
-	return max_sectors << 9;
+	return max_sectors;
 }
 
 static int sg_get_reserved_size(struct request_queue *q, int __user *p)
-- 
2.28.0

