Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC05EBBF7
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Sep 2022 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiI0Huu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Sep 2022 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiI0HuZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Sep 2022 03:50:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D91C435;
        Tue, 27 Sep 2022 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sifwQyqnhpHngKxzCHkDyc0Tyn50ZsV3oCXOspJ4q8=; b=2bIKZsxlAx9aXhDgXX+HxBPjVT
        sfBioXFBqoJn9DYtuzDJWpzkJcpFP+wCx8gHLYOknL2LqM4EIJXT9GyOK0zq1IzarIeMSLOZAsBkT
        fScgQWaVO2G/MU3Tj1ClskLHpdwlIVG6JLItD7DFXEViZuvh68FrKSjdNGzOBdGjCJs1ehBPtAeHc
        LLy3gSYG7EYxXk/ryL7vsFNFwo06pHcZ3IFT1ScjUCnT22icjMMcgnWLA4M0H5S6o8hCdWUUDv5YX
        S52w+dRaGYmUXTs2XusPzIZ8Tn1mu7a0A+uO5CVRbaKXey8unRBx1fs5AWzE/F9xPXysNUYiumjd7
        OaLGI7qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od5ME-008sTT-6b; Tue, 27 Sep 2022 07:50:22 +0000
Date:   Tue, 27 Sep 2022 00:50:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Message-ID: <YzKrPrUvr3wJWCCd@infradead.org>
References: <20220927014420.71141-1-axboe@kernel.dk>
 <20220927014420.71141-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927014420.71141-5-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Sep 26, 2022 at 07:44:19PM -0600, Jens Axboe wrote:
> By splitting up the metadata and non-metadata end_io handling, we can
> remove any request dependencies on the normal non-metadata IO path. This
> is in preparation for enabling the normal IO passthrough path to pass
> the ownership of the request back to the block layer.
> 
> Co-developed-by: Stefan Roesch <shr@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
