Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD261B56BA
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2020 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgDWHyC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Apr 2020 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWHyB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 23 Apr 2020 03:54:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E6C03C1AB
        for <linux-scsi@vger.kernel.org>; Thu, 23 Apr 2020 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NGPx8xb6hDkHvxSYJGXaVanlC7ZJ5J2zgnFMdX5VNPY=; b=FSebLIKPPiv1BKvTRuS4ZVLPQG
        5f/AlsFFxCp27lOocej4PSTFLgjkTNG3BWPW5LEbxnmAxtT98HcKYO2NDVHlsHSYc0T8RVyhi3Xar
        WacIlRdt/kLo+hM0HcQWJ1JbMumQxRNfEaf7iTr7QVZHqrsJfITmzhqy95ZqR1fky8st0C5sy75mj
        ArI8D6lqWTFvcG1ZafyY4SN4FvTcLBj5+1WNFDG1gPvYy0bQenvMLn22mdRSMAPLZPGgBzk2YnH2w
        QJZFV821T0CpcT2Rp95DdUpHfBDpF8OJDmgm+Xn+yZ6V9Mt3jVxwHarbDXO1ovJMIe5tbKoA2Vqmx
        VAaYJCPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRWgL-0000zI-IX; Thu, 23 Apr 2020 07:54:01 +0000
Date:   Thu, 23 Apr 2020 00:54:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, hch@infradead.org,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com
Subject: Re: [v2 3/5] mpt3sas: Separate out RDPQ allocation to new function.
Message-ID: <20200423075401.GA5229@infradead.org>
References: <1587626596-1044-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1587626596-1044-4-git-send-email-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587626596-1044-4-git-send-email-suganath-prabu.subramani@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Apr 23, 2020 at 03:23:14AM -0400, Suganath Prabu wrote:
> For readability separate out RDPQ allocations to new function
> base_alloc_rdpq_dma_pool().
> 
> Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
