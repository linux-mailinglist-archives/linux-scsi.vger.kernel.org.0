Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD66A01E
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 02:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfGPA4v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 15 Jul 2019 20:56:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37119 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732085AbfGPA4u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 15 Jul 2019 20:56:50 -0400
X-UUID: 67650c6ad766468f9b1737099f6b2991-20190716
X-UUID: 67650c6ad766468f9b1737099f6b2991-20190716
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1836918223; Tue, 16 Jul 2019 08:56:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 16 Jul
 2019 08:56:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Jul 2019 08:56:44 +0800
Message-ID: <1563238604.7235.5.camel@mtkswgap22>
Subject: Re: [PATCH v1] scsi: ufs: change msleep to usleep_range
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Date:   Tue, 16 Jul 2019 08:56:44 +0800
In-Reply-To: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bean,

On Mon, 2019-07-15 at 11:21 +0000, Bean Huo (beanhuo) wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> This patch is to change msleep() to usleep_range() based on
> Documentation/timers/timers-howto.txt. It suggests using
> usleep_range() for small msec(1ms - 20ms) since msleep()
> will often sleep longer than desired value.
> 
> After changing, booting time will be 5ms-10ms faster than before.
> I tested this change on two different platforms, one has 5ms faster,
> another one is about 10ms. I think this is different on different
> platform.
> 
> Actually, from UFS host side, 1ms-5ms delay is already sufficient for
> its initialization of the local UIC layer.
> 
> Fixes: 7a3e97b0dc4b ([SCSI] ufshcd: UFS Host controller driver)
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index a208589426b1..21f7b3b8026c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4213,12 +4213,6 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
>  {
>  	int retry;
>  
> -	/*
> -	 * msleep of 1 and 5 used in this function might result in msleep(20),
> -	 * but it was necessary to send the UFS FPGA to reset mode during
> -	 * development and testing of this driver. msleep can be changed to
> -	 * mdelay and retry count can be reduced based on the controller.
> -	 */
>  	if (!ufshcd_is_hba_active(hba))
>  		/* change controller state to "reset state" */
>  		ufshcd_hba_stop(hba, true);
> @@ -4241,7 +4235,7 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
>  	 * instruction might be read back.
>  	 * This delay can be changed based on the controller.
>  	 */
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  
>  	/* wait for the host controller to complete initialization */
>  	retry = 10;
> @@ -4253,7 +4247,7 @@ static int ufshcd_hba_execute_hce(struct ufs_hba *hba)
>  				"Controller enable failed\n");
>  			return -EIO;
>  		}
> -		msleep(5);
> +		usleep_range(5000, 5100);
>  	}
>  
>  	/* enable UIC related interrupts */

Acked-by: Stanley Chu <stanley.chu@mediatek.com>

Thanks,
Stanley



