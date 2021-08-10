Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7F33DFF14
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Aug 2021 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhHDKIs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Aug 2021 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbhHDKIS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Aug 2021 06:08:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69095C0613D5;
        Wed,  4 Aug 2021 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oMvRWCLKrL+bowlss1NI78OonpPCjFhffGqbW1HL1dE=; b=PiGgligciY2JYE5SDrtu6obMwA
        JlTA6jTK8DsWt04NG7bvfXCd+jFrkLqFjyatUHoFYIHCjgKeYJHw3+FkCqJnEq1IM4m6SyvLHfIJB
        IRnccfp2CZ5McjKDNc9c7POb5ql3XzqYFBzggkxh/WzrVV8xKnQttPADvzjZVY/nRh6IDSsdELvrg
        a6ZMV56E6o35SIqhcJHlfw7iPo52vpVltSfZrzxDhEiyw0nqFlqT1n3kVZllZ4u4cF3qVZyWoOD/2
        fgdrcUVO1Ri/vrLWCR+Aym2cAZN57zgC2UrwuLGhgZ/j39gtQYnEJWfxeU8NnOr37FNumoD4pKxGo
        Vjm7IimQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDmp-005fsd-4I; Wed, 04 Aug 2021 10:06:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
        Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 12/15] ps3vram: use bvec_virt
Date:   Wed,  4 Aug 2021 11:56:31 +0200
Message-Id: <20210804095634.460779-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ps3vram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 7fbf469651c4..c7b19e128b03 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -541,7 +541,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 
 	bio_for_each_segment(bvec, bio, iter) {
 		/* PS3 is ppc64, so we don't handle highmem */
-		char *ptr = page_address(bvec.bv_page) + bvec.bv_offset;
+		char *ptr = bvec_virt(&bvec);
 		size_t len = bvec.bv_len, retlen;
 
 		dev_dbg(&dev->core, "    %s %zu bytes at offset %llu\n", op,
-- 
2.30.2

