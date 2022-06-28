Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7E55C6A9
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Jun 2022 14:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbiF1FGE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Jun 2022 01:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbiF1FGC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Jun 2022 01:06:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABAC2654A;
        Mon, 27 Jun 2022 22:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nrVJ3xbYuWr9DU+svOQeQVlZUc
        7ifWn9CcKZ4hfOQZQssurz5HG3u4/tFmPY83NDSFyVt0pD/IQ3Hgaf6HoTwjKfoyMxyduZuILuCRZ
        HLXwVU22Q5pTRuiv/SrhRZlKKTBu1x00I4VO/cUIx+sWpEKClP1SXpCWl4GvrspHGVYjC439qk1mY
        kNh/4bpcK+hj55y5z3az5XROsJIlfjlIBFDXW/3l0EnI5H99Y0hoStS3MrmEXv31MV7oCe9lWyOFt
        PNTRKGji6nn7Z1x3qd0WNhGNwCNmXW3l4XPzr9rjRRhy36//REMVZu5sG47lqt6BdPEyWIHnwXqIu
        dygudfYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o63QH-004JWr-0y; Tue, 28 Jun 2022 05:06:01 +0000
Date:   Mon, 27 Jun 2022 22:06:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH 5/5] scsi: target: Detect unmap support post configuration
Message-ID: <YrqMORjUCq3mee/e@infradead.org>
References: <20220628022953.20948-1-michael.christie@oracle.com>
 <20220628022953.20948-6-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628022953.20948-6-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
