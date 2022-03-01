Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9914C8F77
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Mar 2022 16:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiCAPz5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Mar 2022 10:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiCAPz4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Mar 2022 10:55:56 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE956C2E
        for <linux-scsi@vger.kernel.org>; Tue,  1 Mar 2022 07:55:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC91868BFE; Tue,  1 Mar 2022 16:55:12 +0100 (CET)
Date:   Tue, 1 Mar 2022 16:55:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 1/5] lpfc: kill lpfc_bus_reset_handler
Message-ID: <20220301155512.GA6717@lst.de>
References: <20220301143718.40913-1-hare@suse.de> <20220301143718.40913-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301143718.40913-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Mar 01, 2022 at 03:37:14PM +0100, Hannes Reinecke wrote:
> lpfc_bus_reset_handler is really just a loop calling
> lpfc_target_reset_handler() over all targets, which is what
> the error handler will be doing anyway.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
