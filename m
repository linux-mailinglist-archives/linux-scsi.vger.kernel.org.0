Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE566D5E3
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Jan 2023 07:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjAQGHB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Jan 2023 01:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjAQGG5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Jan 2023 01:06:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357C24ED4;
        Mon, 16 Jan 2023 22:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tKGZHPCxmg4MhBDNlifFe/+FdqQLD/WdvdYuJU2NKGs=; b=IRQDsr+yy8tv+WZ95C2Jh32skp
        ydaKQk9eLAhhqdDjXvyKH+R93aCSW/ACqYCGNR8lEKc8kjFTCU7BL4oa346neL6LyRoa70jdxDVpM
        Mju1GGYyKZ6xu+YgMFUAFELo1O9ees3I79sSR0j5Ya5YWH0DLLONsRQd7pvfNK/mfGnWaxt66h1z8
        Vwfk8XXpEhNJZ5osxv9sZE/DV1Y7YynRWYobilgNwFb33gOwg4ppUiYDpmRA/ax69bRNnXZyK8vkU
        aGAH0n2EwCxcp70NCHcgrKEsLR5bN32cJx2UilTPyeiRbFjpGtYCKYGo71w4GjcqQbaSiWTME6qP2
        M9l1xYvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHf7X-00D2ID-Ni; Tue, 17 Jan 2023 06:06:55 +0000
Date:   Mon, 16 Jan 2023 22:06:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/18] ata: libata: allow ata_scsi_set_sense() to not
 set CHECK_CONDITION
Message-ID: <Y8Y6/xa3thf4/UNy@infradead.org>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-2-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112140412.667308-2-niklas.cassel@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>  void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
> -			u8 sk, u8 asc, u8 ascq)
> +			bool check_condition, u8 sk, u8 asc, u8 ascq)
>  {
>  	bool d_sense = (dev->flags & ATA_DFLAG_D_SENSE);
>  
>  	if (!cmd)
>  		return;
>  
> -	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
> +	scsi_build_sense_buffer(d_sense, cmd->sense_buffer, sk, asc, ascq);
> +	if (check_condition)
> +		set_status_byte(cmd, SAM_STAT_CHECK_CONDITION);
>  }

Adding a bool parameter do do something conditional at the end
of a function is always a bad idea.  Just split out a
__ata_scsi_set_sense helper that doesn't set the flag.
