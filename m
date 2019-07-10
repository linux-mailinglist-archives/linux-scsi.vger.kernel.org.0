Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3E6445F
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGJJ3H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 05:29:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbfGJJ3H (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 05:29:07 -0400
X-UUID: d59ea163da874355aa9b06a90e39c25b-20190710
X-UUID: d59ea163da874355aa9b06a90e39c25b-20190710
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1262152619; Wed, 10 Jul 2019 17:28:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Jul 2019 17:28:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Jul 2019 17:28:56 +0800
Message-ID: <1562750936.7235.3.camel@mtkswgap22>
Subject: RE: [PATCH v2 4/4] scsi: ufs: Add history of fatal events
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Avri Altman <Avri.Altman@wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "ygardi@codeaurora.org" <ygardi@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "sthumma@codeaurora.org" <sthumma@codeaurora.org>,
        "kuohong.wang@mediatek.com" <kuohong.wang@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "chun-hung.wu@mediatek.com" <chun-hung.wu@mediatek.com>,
        "andy.teng@mediatek.com" <andy.teng@mediatek.com>
Date:   Wed, 10 Jul 2019 17:28:56 +0800
In-Reply-To: <SN6PR04MB4925D29D16757A57B25DE369FCF00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1562736017-29461-1-git-send-email-stanley.chu@mediatek.com>
         <1562736017-29461-5-git-send-email-stanley.chu@mediatek.com>
         <SN6PR04MB4925D29D16757A57B25DE369FCF00@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5119A67BB2928397B5A654C3EA45125DE60CF336EA6D500ED74F4F4ACE9CE82C2000:8
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Avri,

On Wed, 2019-07-10 at 08:04 +0000, Avri Altman wrote:
> Hi Stanley,
> 
> > +					       (u32)ret);
> >  			goto out;
> > +		}
> >  	} while (ret && retries--);
> > 
> >  	if (ret)
> Here also link startup fails...

Thanks! Will track this place as well in next version.

> >   * ufshcd_update_uic_error - check and set fatal UIC error flags.
> >   * @hba: per-adapter instance
> > @@ -6043,6 +6056,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
> >  	 */
> >  	scsi_print_command(hba->lrb[tag].cmd);
> >  	if (!hba->req_abort_count) {
> > +		ufshcd_update_reg_hist(&hba->ufs_stats.task_abort_err,
> > 0);
> Here you are collecting abort events statistics, not abort errors.
> If this is what you meant, then it's not task_abort_err, but task_abort.
> And if indeed you are tracking task aborts, maybe add lun resets as well?

Good suggestion! I would add history of lun reset and host reset as well
in next version.

> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index c6ec5c749ceb..f9f109da7f18 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -438,6 +438,10 @@ struct ufs_err_reg_hist {
> >   * @dme_err: tracks dme errors
> >   * @fatal_err: tracks fatal errors
> >   * @auto_hibern8_err: tracks auto-hibernate errors
> > + * @tsk_abort_err: tracks task abort events
> > + * @linkup_err: tracks link-startup fail events
> > + * @suspend_err: tracks suspend fail events
> > + * @resume_err: tracks resume fail events
> >   */
> >  struct ufs_stats {
> >  	u32 hibern8_exit_cnt;
> > @@ -453,6 +457,12 @@ struct ufs_stats {
> >  	/* fatal errors */
> >  	struct ufs_err_reg_hist fatal_err;
> >  	struct ufs_err_reg_hist auto_hibern8_err;
> > +
> > +	/* fatal events */
> Maybe move here fatal_err as well?

OK! these could be classified as fatal errors as well.
Will fix them in next version.

> 
> > +	struct ufs_err_reg_hist task_abort_err;
> > +	struct ufs_err_reg_hist link_startup_err;
> > +	struct ufs_err_reg_hist suspend_err;
> > +	struct ufs_err_reg_hist resume_err;
> >  };
> > 
> >  /**
> > --
> > 2.18.0
> 
> 
> Thanks,
> Avri
> 

Thanks,
Stanley



