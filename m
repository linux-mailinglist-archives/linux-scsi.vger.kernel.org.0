Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A86E97CE
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Apr 2023 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjDTPAj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Apr 2023 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjDTPAi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Apr 2023 11:00:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B335AF
        for <linux-scsi@vger.kernel.org>; Thu, 20 Apr 2023 08:00:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A2BB68AFE; Thu, 20 Apr 2023 17:00:32 +0200 (CEST)
Date:   Thu, 20 Apr 2023 17:00:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, hare@suse.com, hch@lst.de,
        bvanassche@acm.org, jinpu.wang@cloud.ionos.com,
        damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com
Subject: Re: [PATCH v2 1/3] scsi: libsas: Simplify sas_check_eeds()
Message-ID: <20230420150031.GA11103@lst.de>
References: <20230420143339.2769414-1-yanaijie@huawei.com> <20230420143339.2769414-2-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420143339.2769414-2-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Apr 20, 2023 at 10:33:37PM +0800, Jason Yan wrote:
> In sas_check_eeds() there is an empty branch. We can reverse the
> test expression and then remove the empty branch. Also the the test
> expression is a little bit complex so it deserves an individual
> function. And make the continuing prototype lines indented after
> the opening parenthesis to follow the standard coding style.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/scsi/libsas/sas_expander.c | 39 +++++++++++++++---------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index dc670304f181..70fd4f439664 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1198,37 +1198,36 @@ static void sas_print_parent_topology_bug(struct domain_device *child,
>  		  sas_route_char(child, child_phy));
>  }
>  
> +static bool sas_eeds_valid(struct domain_device *parent, struct domain_device *child)

Please avoid the overly long line.
