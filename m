Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1766D706
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Jan 2023 08:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjAQHhn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Jan 2023 02:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjAQHhl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Jan 2023 02:37:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388761CACC;
        Mon, 16 Jan 2023 23:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=otpw2Cw2/3zBLSODYzFRGx5P9bTnWKfgSIRs0Ryudrc=; b=f6GP0dlR1RkS5tfaxb3JFB48lE
        64imitWnR5K1jqDzhCwo/k/4efkr9CcYX1Dqfo7SLOPWRZopIHzuzlp6AAtbdJUnlVUgN87sED116
        WDBJ1EL5erA+/DRMAxxK0ExbeTLYBq4BG0rsoGjppZyVUdPAkImMySa7I8K9f9ZXwVvqv+ty4H2Sy
        /bL3yHinTHWuWD7FbDza9u43hl8jprldV3Duo+lP9U/ODzazeqfwkO2QnkSjeGaVPkgxJ4JGFZaYG
        Hj5ab3eqaEc8z6384m5uYuHstJcsmfpftCUpQIAyIsikbgYjXjzU+icCTWM+wRZ27P9mFmVGkV5Mq
        5Im/Qh/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHgXJ-00DDTt-8x; Tue, 17 Jan 2023 07:37:37 +0000
Date:   Mon, 16 Jan 2023 23:37:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 14/18] scsi: sd: detect support for command duration
 limits
Message-ID: <Y8ZQQRO/O/3JjHtV@infradead.org>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-15-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112140412.667308-15-niklas.cassel@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Is sysfs really the right interface here?  I would have expected an
ioctl (and for kernel use method) on the block device to more
useful.  Especially all the dynamic sysfs manipulation from a driver
is a little scary to me.
