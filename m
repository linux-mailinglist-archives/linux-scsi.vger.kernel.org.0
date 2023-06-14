Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74D57276E6
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Jun 2023 07:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjFHFsM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Jun 2023 01:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjFHFsL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Jun 2023 01:48:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D732697;
        Wed,  7 Jun 2023 22:48:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 76F906732D; Thu,  8 Jun 2023 07:48:06 +0200 (CEST)
Date:   Thu, 8 Jun 2023 07:48:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 7/8] scsi: have scsi_target_block() expect a
 scsi_target parent argument
Message-ID: <20230608054806.GD11554@lst.de>
References: <20230607182249.22623-1-mwilck@suse.com> <20230607182249.22623-8-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607182249.22623-8-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 07, 2023 at 08:22:48PM +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> All callers (fc_remote_port_delete(), __iscsi_block_session(),
> __srp_start_tl_fail_timers(), srp_reconnect_rport(), snic_tgt_del()) pass
> parent devices of scsi_target devices to scsi_target_block().
> Simplify scsi_target_block() to assume that it is always passed a parent
> device.

Btw, one thing I realized is that the function has been a bit misnamed
for a while, and becomes even more so now.  Maybe scsi_block_targets
is a better name as it blocks all the targets hanging off the
passed in devices as children?
