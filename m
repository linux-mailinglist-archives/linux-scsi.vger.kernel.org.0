Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13666D5E8
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Jan 2023 07:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjAQGIZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Jan 2023 01:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAQGIX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Jan 2023 01:08:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03784ED4;
        Mon, 16 Jan 2023 22:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A8ky6yNsLDoY+EmpsF/Wb+0nGEJz+EcOpwPNBBcITm4=; b=D3gkOsCJwq/lPJN9YD7LphJpk2
        Fz9h3MkWNB5ytAUCcK/iVUhYhfIsaCRuvYyO4dGCVvroLdKEp0/ltMnYYfBRHiPI+Yz6pmisCXjBm
        BEzqEUWaiOisr3VESXHzHTDWBbs4do4IeyjNT+RDUCUmU3gdbq9oWMtUUqgNcqsBThJLeSVbo1xxR
        rnaVN6DdCb0Xja/uNvS81rCjc1e7nj2KguCflFdoA/vWSOGMTTGUKrWlaAjrbM4fulRTM+kIxC2BQ
        1Ae9KYZnj9e6H2G+lxUWGXezCVGus5M7HQfTW4skJEsos8M5qMZ+/ZuRgHFAoFz3RCf0DJDGhb56l
        P2wiR/mA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHf8u-00D2Oo-OM; Tue, 17 Jan 2023 06:08:20 +0000
Date:   Mon, 16 Jan 2023 22:08:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/18] ata: libata: allow ata_eh_request_sense() to
 not set CHECK_CONDITION
Message-ID: <Y8Y7VBnqOb/KXKal@infradead.org>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-3-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112140412.667308-3-niklas.cassel@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Similar comment here - just move setting the SAM_STAT_CHECK_CONDITION
out of this function and into the caller.  It'll need a bool return for
that, though.
