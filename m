Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42E42F27E
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Oct 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbhJON3x (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Oct 2021 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbhJON3a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Oct 2021 09:29:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43453C061764;
        Fri, 15 Oct 2021 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=brrNeCrpSVGZomYuK+0XdDRpBpOzq/Tfwu+Oh+282Uo=; b=IxLeKtcq5OzxV91L8hTsh+7Wn6
        GlocDXjqZDpKZlfP0UYVJ6BEdGYan+wi1rVHDqD7apTedacgzPz/ay+ildx+shvtzPpsAEQ1PxRZu
        F+2A+Xp7CEiJPBI1rRydwkIH3jEs5fLQZYWGW7ZpoXWC7/sqRQB4Q+yfmq/NjEBYZFGbvSIFKLP+5
        HZ4numWQM2crsRS3Y0bBhZdCBgmIt8jZTZI3m2/tYEQs9btUPJ0nPqDcW8keyyKPd6rkEI37HdlUh
        /Iaszs3O8OiNHbWqQ1Xfy8qE3WbJ7te1x7WzzugXIOJXRQ3cv3Gn1lYYgA5DwQWsjfPpsJA9Bqe7z
        peZfYXaQ==;
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNEr-007CtU-GU; Fri, 15 Oct 2021 13:27:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 09/30] fs: use bdev_nr_bytes instead of open coding it in blkdev_max_block
Date:   Fri, 15 Oct 2021 15:26:22 +0200
Message-Id: <20211015132643.1621913-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c615387aedcae..156358977249f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -878,7 +878,7 @@ link_dev_buffers(struct page *page, struct buffer_head *head)
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 {
 	sector_t retval = ~((sector_t)0);
-	loff_t sz = i_size_read(bdev->bd_inode);
+	loff_t sz = bdev_nr_bytes(bdev);
 
 	if (sz) {
 		unsigned int sizebits = blksize_bits(size);
-- 
2.30.2

