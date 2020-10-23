Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2229788A
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Oct 2020 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755547AbgJWU5f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Oct 2020 16:57:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:41952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755499AbgJWU5e (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Oct 2020 16:57:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86181AC2F;
        Fri, 23 Oct 2020 20:57:33 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/5] lib/scatterlist: use consistent sg_copy_buffer() return type
Date:   Fri, 23 Oct 2020 22:57:19 +0200
Message-Id: <20201023205723.17880-2-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023205723.17880-1-ddiss@suse.de>
References: <20201023205723.17880-1-ddiss@suse.de>
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
index 9a4992dc8e8c..be8d6f4c1c05 100644
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

