Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F06F7CA5
	for <lists+linux-scsi@lfdr.de>; Fri,  5 May 2023 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjEEGBv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 5 May 2023 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjEEGBu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 5 May 2023 02:01:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3511610
        for <linux-scsi@vger.kernel.org>; Thu,  4 May 2023 23:01:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EAC868C7B; Fri,  5 May 2023 08:01:46 +0200 (CEST)
Date:   Fri, 5 May 2023 08:01:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.g.garry@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Changyuan Lyu <changyuanl@google.com>,
        Jolly Shah <jollys@google.com>,
        Vishakha Channapattan <vishakhavc@google.com>
Subject: Re: [PATCH v2 3/5] scsi: core: Trace SCSI sense data
Message-ID: <20230505060145.GC11897@lst.de>
References: <20230503230654.2441121-1-bvanassche@acm.org> <20230503230654.2441121-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503230654.2441121-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 03, 2023 at 04:06:52PM -0700, Bart Van Assche wrote:
> If a command fails, SCSI sense data is essential to determine why it
> failed. Hence make the sense key, ASC and ASCQ codes available in the
> ftrace output.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although, I'd also love to see pre-decoded ASC and ASCQ codes in the
scsi_cmnd at some point.
