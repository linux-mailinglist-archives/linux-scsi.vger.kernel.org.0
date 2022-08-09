Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD358D5B3
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Aug 2022 10:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbiHIIvr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Aug 2022 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHIIvp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Aug 2022 04:51:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC138B7
        for <linux-scsi@vger.kernel.org>; Tue,  9 Aug 2022 01:51:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DF9E68AA6; Tue,  9 Aug 2022 10:51:41 +0200 (CEST)
Date:   Tue, 9 Aug 2022 10:51:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Dave Prizer <dave.prizer@hpe.com>
Subject: Re: [PATCH RESEND] scsi: scan: retry INQUIRY after timeout
Message-ID: <20220809085140.GA17793@lst.de>
References: <20220808202018.22224-1-mwilck@suse.com> <251c6042-5778-5d82-64e3-a2de5e1e2d36@oracle.com> <20220809065247.GA9663@lst.de> <3fa3ad7169546b1c7e9196474a29e96b719ebe67.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa3ad7169546b1c7e9196474a29e96b719ebe67.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Aug 09, 2022 at 10:50:50AM +0200, Martin Wilck wrote:
> Are you suggesting to re-invent REQ_OP_SCSI_{IN,OUT} to distinguish
> SG_IO from kernel-internal passthrough?

No.  We just need a flag in struct scsi_cmnd that controls the retry
behavior for passthrugh commands.
