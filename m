Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD46529967F
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Oct 2020 20:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1792636AbgJZTNp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 15:13:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:44154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1736547AbgJZTH0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Oct 2020 15:07:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4ABCAE5C;
        Mon, 26 Oct 2020 19:07:25 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 1/5] lib/scatterlist: use consistent sg_copy_buffer() return type
Date:   Mon, 26 Oct 2020 20:06:42 +0100
Message-Id: <20201026190646.8727-2-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026190646.8727-1-ddiss@suse.de>
References: <20201026190646.8727-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

sg_copy_buffer() returns a size_t with the number of bytes copied.
Return 0 instead of false if the copy is skipped.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 0a482ef988e5..a59778946404 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -933,7 +933,7 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
 	sg_miter_start(&miter, sgl, nents, sg_flags);
 
 	if (!sg_miter_skip(&miter, skip))
-		return false;
+		return 0;
 
 	while ((offset < buflen) && sg_miter_next(&miter)) {
 		unsigned int len;
-- 
2.26.2

