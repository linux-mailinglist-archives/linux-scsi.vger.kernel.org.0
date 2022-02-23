Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A764C1371
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Feb 2022 13:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiBWM70 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Feb 2022 07:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiBWM70 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Feb 2022 07:59:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2040C2C137;
        Wed, 23 Feb 2022 04:58:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E3C768AA6; Wed, 23 Feb 2022 13:58:56 +0100 (CET)
Date:   Wed, 23 Feb 2022 13:58:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 3/8] scsi: don't memset the entire scsi_cmnd in
 scsi_init_command
Message-ID: <20220223125855.GA4489@lst.de>
References: <20220222140443.589882-1-hch@lst.de> <20220222140443.589882-4-hch@lst.de> <f5c2f7e0-6b14-222f-ba16-696b29517296@huawei.com> <20220223123940.GA4205@lst.de> <75ccb490-3c77-b7d9-815a-8bf1698f0848@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75ccb490-3c77-b7d9-815a-8bf1698f0848@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 23, 2022 at 12:56:32PM +0000, John Garry wrote:
> For the record, advantages now could include:
> - prob more efficient
> - somewhat safer coding practice
> - more condense C code
>
> But, for sure, it's not so pretty to have this sub-struct.
>
> Anyway, I don't feel too strongly about it and it was just a suggestion.

In general most of the zeroing here should go away entirely.  Right
now that code is a bit convolute due to the fake EH scsi command that
also uses scsi_init_command.  Once that is sorted out (I've just pinged
Hannes for his series) scsi_init_command can be folded into
scsi_prepare_cmd and a lot more of this can be cleaned up.
