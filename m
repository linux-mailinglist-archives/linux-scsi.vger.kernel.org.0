Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2CB6E97DA
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Apr 2023 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjDTPCI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Apr 2023 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDTPCG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Apr 2023 11:02:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569B3359D
        for <linux-scsi@vger.kernel.org>; Thu, 20 Apr 2023 08:02:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E0B8668AFE; Thu, 20 Apr 2023 17:02:01 +0200 (CEST)
Date:   Thu, 20 Apr 2023 17:02:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, hare@suse.com, hch@lst.de,
        bvanassche@acm.org, jinpu.wang@cloud.ionos.com,
        damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com
Subject: Re: [PATCH v2 2/3] scsi: libsas: Remove an empty branch in
 sas_check_parent_topology()
Message-ID: <20230420150201.GB11103@lst.de>
References: <20230420143339.2769414-1-yanaijie@huawei.com> <20230420143339.2769414-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420143339.2769414-3-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Apr 20, 2023 at 10:33:38PM +0800, Jason Yan wrote:
> There is an empty "All good" branch in sas_check_parent_topology(). We can
> reverse the test statement and remove the empty branch.

Eww, this code is pretty unreadable (as-is and after the change).
Can you move SAS_EDGE_EXPANDER_DEVICE case into a helper to
make it readabke?  That has the extra upside of just being able to
return the error code instead of assigning it to res.
