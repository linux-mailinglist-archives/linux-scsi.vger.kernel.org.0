Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DF6EC68B
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Apr 2023 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjDXGwK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Apr 2023 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDXGwE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Apr 2023 02:52:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A640EB
        for <linux-scsi@vger.kernel.org>; Sun, 23 Apr 2023 23:51:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1662F68B05; Mon, 24 Apr 2023 08:51:50 +0200 (CEST)
Date:   Mon, 24 Apr 2023 08:51:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, hare@suse.com, hch@lst.de,
        bvanassche@acm.org, jinpu.wang@cloud.ionos.com,
        damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com
Subject: Re: [PATCH v3 2/3] scsi: libsas: Remove an empty branch in
 sas_check_parent_topology()
Message-ID: <20230424065149.GB11582@lst.de>
References: <20230421093744.1583609-1-yanaijie@huawei.com> <20230421093744.1583609-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421093744.1583609-3-yanaijie@huawei.com>
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
