Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5651612A71
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Oct 2022 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJ3Lwx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Oct 2022 07:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJ3Lww (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Oct 2022 07:52:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169AEC75E
        for <linux-scsi@vger.kernel.org>; Sun, 30 Oct 2022 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GHfwfIt7SK5Yc61oNPNolVO50QrSz7gJd4jMmZ6T6KA=; b=N1KL8QX6k4+xLApoYu2FJKSKN3
        0F79VVhAuc5NtAQkxwwK0lLGdt5p1brPRcenQyBZumkr59XRfBH07J9Mr+VIVWymqVzXigXMmlNRN
        9FXUDJz96kWw6feFXCV7kBKqvHY9FOFLkxWmRLtPWfpAv/4GNKjeunmlzRlrKJ8bDtmVxJmOjPFgh
        L7dEPxEjlo/Oc+lSzbepvhXdy2jN7emvLT9j5APwYfF2I5auTv/7InA/cOXC9JbpwLfej9bkydZ+4
        u52MPZm8bdviwskcVP6MBW516KD51BydG2ch3rsokbrM7Sea60PDN9L8pHy6hWO/hJSCatGVjKCHM
        +Z5ItMXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op6rz-00FlyV-Hb; Sun, 30 Oct 2022 11:52:51 +0000
Date:   Sun, 30 Oct 2022 04:52:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/1] mpt3sas: Remove usage of dma_get_required_mask api
Message-ID: <Y15lk+CPsjJ801iY@infradead.org>
References: <20221028091655.17741-1-sreekanth.reddy@broadcom.com>
 <20221028091655.17741-2-sreekanth.reddy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028091655.17741-2-sreekanth.reddy@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Oct 28, 2022 at 02:46:55PM +0530, Sreekanth Reddy wrote:
> Remove the usage of dma_get_required_mask() API.
> Directly set the DMA mask to 63/64 if the system
> is a 64bit machine.
> 
> Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
