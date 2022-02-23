Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5113F4C12E0
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Feb 2022 13:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiBWMkM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Feb 2022 07:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiBWMkL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Feb 2022 07:40:11 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B28A27A4;
        Wed, 23 Feb 2022 04:39:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A4A4468AA6; Wed, 23 Feb 2022 13:39:40 +0100 (CET)
Date:   Wed, 23 Feb 2022 13:39:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 3/8] scsi: don't memset the entire scsi_cmnd in
 scsi_init_command
Message-ID: <20220223123940.GA4205@lst.de>
References: <20220222140443.589882-1-hch@lst.de> <20220222140443.589882-4-hch@lst.de> <f5c2f7e0-6b14-222f-ba16-696b29517296@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c2f7e0-6b14-222f-ba16-696b29517296@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 23, 2022 at 12:21:10PM +0000, John Garry wrote:
> I am just wondering did you consider using struct_group() for safety?
>
> I don't think the scsi_cmnd members have special ordering apart from 
> co-locating related members.
>
> Here's how it could look (on top of yours):

Besides being ugly as hell I don't see the benefit.  Quite contrary,
a lot of these fields are properly initialized later and we can drop
the zeroing as well, but I'd rather do that separately and with a proper
audit.
