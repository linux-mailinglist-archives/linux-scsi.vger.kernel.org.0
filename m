Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922D540C0BE
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Sep 2021 09:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhIOHrV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhIOHrT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Sep 2021 03:47:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925FC061574;
        Wed, 15 Sep 2021 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nnSa7P336VGGk9Limvd7GwXLYg/oH4OMYdyuRmtulc8=; b=OcNA9ZWLwCEof9xZCbhUvoMnkr
        duiUXizcvSczod/ZrpCDZOnMqML6D9zTBnPEY+x6+BBoZHR3q8KhW6KuapOOkHci9Wvi30pbbBbOy
        puvS87zCM3I7qfProzjufEvKI/TPRHtdJZ8iOxLVGFqiL9y9S2FwcNNDuHJDrCoLPKJ8jKyhLu1u0
        J+TUXDkJj4rKkx4qcqNr2DYgW0M+wkBIwS+JjCSfIAJ9G3+R9nNypr1Kex3P0vqiQEBEtawncssji
        iA/dqH9tFEpzaaV95QvecIxhCpINzNwBdRszxFZzsAERSKYFlWFuEikkg12qH2lGDzNhoHgdDASiA
        G2/jTzrA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQPbI-00FTEv-Dl; Wed, 15 Sep 2021 07:45:24 +0000
Date:   Wed, 15 Sep 2021 08:45:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        Satya Tangirala <satyaprateek2357@gmail.com>
Subject: Re: [PATCH 3/5] blk-crypto: rename keyslot-manager files to
 blk-crypto-profile
Message-ID: <YUGkfDmGa3WKz8cD@infradead.org>
References: <20210913013135.102404-1-ebiggers@kernel.org>
 <20210913013135.102404-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913013135.102404-4-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

It would be nice to keep the blk-crypto* includes together, though.
