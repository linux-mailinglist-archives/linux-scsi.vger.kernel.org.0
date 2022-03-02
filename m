Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA024CA12F
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 10:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiCBJs3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 04:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiCBJsY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 04:48:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08604B409
        for <linux-scsi@vger.kernel.org>; Wed,  2 Mar 2022 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DAhynBveryOkMhCWzh0QNCLq1sehuzHQANqXEqA7DK4=; b=1C0rZVkz7VUA/pawuqf7SLAe/G
        RFLqz7as9+DFYU58r+v7jWDjrmWmE7ua8/PVsOEpwN2MRNeh4COcuiW4aIkV0Rbzo85IXh6qeg2kq
        UwzSP1wFSFgpsmXJlJVOHL8sknAOKe6Z8KAhM5HYfs6UzapttpKEP/CvitwGfWPce8AzY6d40bFNH
        XaMZ5eI2AWtuOWFSQ3njRAkB8mzrg52PLwznk6FXdGVyCfELOd0HVepMiEAh9CbezgnjXZgxqOwTN
        lc8LdYexGrzBuc1fbpaqu77uClFRe/zW0yEuanMOA2NY4ysPMd+V2V1ppEufpfyd4Z4pST0jHkPhG
        bxXqEeCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPLa7-0026zc-L6; Wed, 02 Mar 2022 09:47:39 +0000
Date:   Wed, 2 Mar 2022 01:47:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: Re: [PATCH 01/14] scsi: mpt3sas: Use cached ATA Information VPD page
Message-ID: <Yh89O5iqPCxesV4K@infradead.org>
References: <20220302053559.32147-1-martin.petersen@oracle.com>
 <20220302053559.32147-2-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302053559.32147-2-martin.petersen@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Mar 02, 2022 at 12:35:46AM -0500, Martin K. Petersen wrote:
> We now cache VPD page 0x89 so there is no need to request it from the
> hardware. Make mpt3sas use the cached page.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
