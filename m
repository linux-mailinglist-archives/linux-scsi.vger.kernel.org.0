Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8006773B034
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Jun 2023 07:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFWFoO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Jun 2023 01:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWFoM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Jun 2023 01:44:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDDE46;
        Thu, 22 Jun 2023 22:44:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 320A567373; Fri, 23 Jun 2023 07:44:07 +0200 (CEST)
Date:   Fri, 23 Jun 2023 07:44:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, yukuai3@huawei.com, axboe@kernel.dk,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
Message-ID: <20230623054406.GB9085@lst.de>
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

