Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEF58FC15
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Aug 2022 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiHKMVv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Aug 2022 08:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiHKMV2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Aug 2022 08:21:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3998E0DA
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 05:21:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0098968AA6; Thu, 11 Aug 2022 14:21:23 +0200 (CEST)
Date:   Thu, 11 Aug 2022 14:21:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, mwilck@suse.com, hch@lst.de,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH 2/4] scsi: Add new SUBMITTED types for passthrough
Message-ID: <20220811122123.GB1742@lst.de>
References: <20220810034155.20744-1-michael.christie@oracle.com> <20220810034155.20744-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810034155.20744-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Aug 09, 2022 at 10:41:53PM -0500, Mike Christie wrote:
> This adds 2 new SUBMITTED types so we know if a command was queued
> because of a scsi_execute user vs SG IO/tape/cd.
> 
> In the next patch we can then handle errors differently based on what
> submitted the cmd. For scsi_execute we can let the scsi error handler
> retry like normal if the user has requested retries. And for other users
> we can fail fast for device errors like is expected by users like SG IO.

But do we really want to handle errors differently based on the
submitter, or based on what the submitter asks us to do?  I.e. why
should this be based on the callchain vs the intention?
