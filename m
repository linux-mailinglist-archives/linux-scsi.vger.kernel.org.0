Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3988173B02B
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Jun 2023 07:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFWFkp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Jun 2023 01:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjFWFkk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Jun 2023 01:40:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B4D2139
        for <linux-scsi@vger.kernel.org>; Thu, 22 Jun 2023 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3BDwGMORJZn7hXcXLNyQ/xvyvPaF34QPU9y9KJr5Z7U=; b=XKhKkrDs2Tw9j7iGi7sBd72gX7
        /IrFBmEC6L1FORr114NQKdBBxuROPNgbhcPlSbm1LJyhRL04gmUK0dit5/YmHxZF5zzx2W5N8ZVIY
        fxxA4oTBadOT83Hcgbd5CwCXoPiwxPilxTAfRKtDc9Kr0VnlatHZXUukebClPziX7MgKxNJ00I1ji
        zxjEs77EU2rnzhKbS3vS9JCpaP7IcPS/+d/BRFBHMdpSPdBSp7IbtV3+b+4/dxqXAejK4VvaE4fuJ
        LVrYiwb253g0V0NWyh4Al+2akfr6JCbFMJVzmnOtvG5zrlgYqsPKQIPLCW/TGHiGYaatfBKqBdHJ5
        VYOxkitw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qCZWs-002cRJ-2P;
        Fri, 23 Jun 2023 05:40:18 +0000
Date:   Thu, 22 Jun 2023 22:40:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] scsi: Simplify scsi_cdl_check_cmd()
Message-ID: <ZJUwQvdRyr1v6wVX@infradead.org>
References: <20230623002912.808251-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623002912.808251-1-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +	 * See SPC-6, one command format of REPORT SUPPORTED OPERATION CODES.

/one/on/ or even on the?
