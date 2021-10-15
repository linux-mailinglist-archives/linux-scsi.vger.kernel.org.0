Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7EA42F93D
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Oct 2021 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhJOQ7J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Oct 2021 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbhJOQ6L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Oct 2021 12:58:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3306C061767
        for <linux-scsi@vger.kernel.org>; Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q5so9110271pgr.7
        for <linux-scsi@vger.kernel.org>; Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dBqAYLNOJEEerwqZkr8h1WW5rIZpnbVROvIlOTScyoI=;
        b=a7qtweAUbS8K+NvWs4UCJMddQ3rECf/7QZ6zgMst5BcQ7TbdTIW8B/A36zncKdA0GG
         8KMhkxj+OzPkhorCWgeiV72Q4Wcq28WkBpsAyjDJDIhvh57vqCJGOPQwvw9YxRM4d1BS
         rdcHafc3+6KUZpEfQohGLoX5kTVxG/qsPhu90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dBqAYLNOJEEerwqZkr8h1WW5rIZpnbVROvIlOTScyoI=;
        b=7H/EPDjRSWlj4W2x/mRp3FwugiRn4WqtLTMELMcH1Ml/RWIwrar2xIiaBDtvZvYAST
         tWS95PPol6RhF3Mkc0sg8iI51YjYEJgbaEnNTspjQCrjCecDD9RO4dzXa8EMLYro4EgM
         rVAE09jIadIYdGR8GaVrBQScWQJufHbbtQtHLsdJpQd+FitUYSQWvBc4K0fVgGMTSydv
         0WvWqUW3mag523sqId1WCQDnrGOtI2/D3fz1sT8sL3oxXdb7UMXYyEBGQfQuHk8eFVRC
         rcAiQtiHik1u6PXH8xqIUH3NaODN/u9J0SG1ygZxZD/2HdI57nsFOtfuOOg63sroJnKF
         qvEg==
X-Gm-Message-State: AOAM532r5Y83hyWrKSwLLMUGCoVtFJatyBDoLG/Wjt1MA7yzH7gM4byv
        Gpl01LLuK2Vb03nsmz/zWZubSA==
X-Google-Smtp-Source: ABdhPJwArKSP1GbQ25tbhNDvzZCNcxogaP2mPI5IH6CBqZA2sACP5s1J2IGQKikEyZ/PadmXHII8iA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr9960371pgs.219.1634316964288;
        Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m12sm5254518pjv.29.2021.10.15.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:56:04 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:56:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 21/30] pstore/blk: use bdev_nr_bytes instead of open
 coding it
Message-ID: <202110150955.495735B@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-22-hch@lst.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:34PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the bdev_by_bytes() helper; this is more readable now. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
