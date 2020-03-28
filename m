Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B34B196463
	for <lists+linux-scsi@lfdr.de>; Sat, 28 Mar 2020 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgC1IWL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 28 Mar 2020 04:22:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1IWL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 28 Mar 2020 04:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nc888JpTgVIfXX5tVvoxp3UN2s0cRXynP/qnhs+Hwy8=; b=XgREbhzMpd5HkrKpjlA9cUGtI4
        4hrjvagAsWRvqxflM0ZOOp37ytOqLDqdHGM3TmPC9J4udmf9PP8TNUgXLWN53JolNW8IbFhCKzrcT
        yYEn5scJryTgbBqG1AikejxeLjdJHMyxi7NBBkKfLz82O4UZHPLSwDOx24/XaOJGWBPgotRX4KbQY
        RhJrhgExxOsohYGnNDW9CugnMYka/pC7MV4gx54fmWMoVZcGiwcdM9/MfH8QPRPQigzctr1oYR61V
        1M72svYro5cesUF4I9Qp9hqWmpVro95v5Tnp+53xyaM1Rk2iOV8zuRYL+KzLlSGijafaYps0G6tPB
        uqQcRrtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI6jL-0001sf-6l; Sat, 28 Mar 2020 08:22:11 +0000
Date:   Sat, 28 Mar 2020 01:22:11 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: all zones zone management operations
Message-ID: <20200328082211.GA32518@infradead.org>
References: <20200326043012.600187-1-damien.lemoal@wdc.com>
 <20200326072800.GA21082@infradead.org>
 <CO2PR04MB23433C37660B9A8B53D95790E7CF0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <20200326093049.GB6478@infradead.org>
 <CO2PR04MB234368B6701C041B292DC872E7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB234368B6701C041B292DC872E7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Mar 28, 2020 at 08:13:26AM +0000, Damien Le Moal wrote:
> In any case, I think that the patch has value as a nice cleanup of the reset vs
> reset all request operations (the latter going away). The side effect of it
> being that open/close/finish all come for free with it. I would like to get it
> in just for this nice cleanup.

Well, this keeps about the same amount of core code (and I'm not sure
it really is cleaner) while adding significantly more code in sd and
null_blk.  Not my classic definition of a cleanup.
