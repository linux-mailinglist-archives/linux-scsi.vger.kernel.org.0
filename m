Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B104CA15A
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbiCBJw0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 04:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiCBJwW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 04:52:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE781BA760
        for <linux-scsi@vger.kernel.org>; Wed,  2 Mar 2022 01:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=KOWB2BTmvsidFpVtvurYgwto7Q
        HjiiLZvt0qkysAKKNDTH6B6oEXuhafMppqpoSKYTb1j8fX6vz6yU3W33320YekOial+XXxHIwZCO5
        NRjXVqdXOMNlQOzM3dVxgENj1dDeNMC7lHl4/Hl8eQ5TBElGQ2uOSzcvv5CZe+ObPdMNB81Z5HPIw
        8pboIznQ0MjynJn4Y3wwm/4V7ClVmgX0LDSw5fmXzhHKfH4hPiMFhR7BniDDSZa98sRLNhlEetjqk
        rT9+o4K07937BPVrBDa90mdJIVqddY6a3gpGfYXLdpDkYDhTnIkjJV0Nveh7M0subUHSX3XgX6zrt
        qdAlMWcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPLdy-0028pd-HB; Wed, 02 Mar 2022 09:51:38 +0000
Date:   Wed, 2 Mar 2022 01:51:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bernhard Sulzer <micraft.b@gmail.com>
Subject: Re: [PATCH 08/14] scsi: sd: Optimal I/O size should be a multiple of
 reported granularity
Message-ID: <Yh8+Kt1uMd4sgE2r@infradead.org>
References: <20220302053559.32147-1-martin.petersen@oracle.com>
 <20220302053559.32147-9-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302053559.32147-9-martin.petersen@oracle.com>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
