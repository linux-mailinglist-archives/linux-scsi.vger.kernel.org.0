Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1C8080C
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 21:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfHCTez (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 15:34:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:52223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfHCTez (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 3 Aug 2019 15:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564860885;
        bh=H4FqaDlzWr6uTximuJKkr7vJsJJJqkZsliJDMo6J/Mw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=NLJ83fLbH69Edb54Tyj9O6wosmGq/WJ06m/4Wm+4BncWXtNwS+i3HHz0DG5RBp+0J
         CFrL48KpftYvHFgZ1Wyw1jc2M/iwdIqmsfRjOnzk8Y6GicR08wzcRMxUYWnX03erM/
         QQFx5emcONddHHectpLBbDQIjqfA2cEKePdwHcS8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([79.203.56.157]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WRI-1iGuvx1NIi-00ygjo; Sat, 03
 Aug 2019 21:34:45 +0200
Date:   Sat, 3 Aug 2019 21:34:43 +0200
From:   Helge Deller <deller@gmx.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] scsi: ncr53c8xx: Mark expected switch fall-through
Message-ID: <20190803193443.GA3385@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Provags-ID: V03:K1:iP6S+LX9bmarKyqYhMxAn3LDKEuEPBtLadQIdX7dRH8kWv5Z5WP
 zYT2HKQ4cGoOq7ncFFNJVwgErnkXbxjVObjbqieZyxH+Yc1f7PqqgJcn9WNre3bgEyQpmww
 1SfgbUGojd63dpi3qJr4fEQdhbTz/DWxk1mWPLR1ACRWxj7rU/lrmpD+VAYX166bNItd5c2
 QtelayP6RtgBzijqLiY9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mkjtlf9WQVU=:nIRNtu+Esv+0ALJa7TNp2L
 mkZA/4Oi0tbr4BIdOF0IBk4GTJmInzaekgbaaWBntxMpzWBq67eAncWrrDg2x3HAjow7eVXTa
 QBqJIRzheDwJpBLgweEnvaFQMPgJ+5yCe+R2mlQYuf9kiPlmL4uCGqs4fAD7aEupNvlQaIQSj
 aAy/XpDz9boUGqpncC5+AqtQmQX5qWA890fDqPu8D4ChdPzXMBKAGccS7StLbFThD2BW0JfEf
 +ocgNGtnBU1q0/BGJb51UPNpI30ZvRmhXT1dMCbO28Xjp8F4ZOdCtuFYkx+JbUkAZ7ftLkGmO
 N0uQa9R1oZMIcdliozieggjunNdrFkloZ8SbMbre8R2QHnKbUuaN5hdDT86fQG3ciA27+bzfH
 FUfkAlN3LxElY5b4SliWLbnmTYS3obwvQLOXiLWB23i+h/Q9CaP8HEuHY5D1gN51/p6yW7phR
 S84WuADXciAhjUHLYaiRpuluirsM/9TdG21AFQekdgPQjZhTEct6F6INaub1MvqVheWr2Zle8
 yX1BRtSBpyUU4cbWnU3AHNKa6b6yVD3laE6B7c3n+ZRTqfNSYAecK+yiNIdbX+GzlD37R4g1s
 1OTzCrLsPN/Tp1F81HJGIJolMsxukiERzzs0wZU8iSqdBsj83dUSpa8GQkT5CL8M32V4VnBtJ
 bKKDN25rnyRJBzdO8aD98Wn0pZ6aR4+fNTNzAzBV8SwGQL12JPBdv6cG4jxZQ904COKP5damf
 ceHLoqjjNmkSCvhFIuRRHwDAcLYJXbVmucp3o4+PacVL6v7CYaKKjqr+QeULasHvsxpb/r/LY
 ZvLLYQAqL7EqhXi5DSkOSV2gvv+sK4+XaLWmYF1UiwWe1Ra+TWwoasJ16jVUkzxz3m7ekVUtb
 AWmGd1OmiFY+yvuFEZ7HD0V2WOpRLYnUfaArFChjrJVB7wYG5z1HA117aiK0PKF4XD6w5gqLA
 zfMLulqt7ZPbSzW/FL4gy2qtJ50axY3O9nRkUA14dLO1EVgS7+eIM/6Gn/bfr2WX8LoniL9m5
 xkAvTsFalOEV6lcbNQtLFGG2ueWZvQIUKR0ZJxa5mbKoKYi2qXqNA7F/RrxcNxQ99StTusflq
 OAlcPj49vY+Zaf/daZjcbIjjN3e90xMqM/h53WsCad0ga+eAw8cpnVYjQ==
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index e6a95498ac0d..e0b427fdf818 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -3910,11 +3910,14 @@ static void __init ncr_prepare_setting(struct ncb *np)
 					np->scsi_mode = SMODE_HVD;
 				break;
 			}
+			/* fall through */
 		case 3:	/* SYMBIOS controllers report HVD through GPIO3 */
 			if (INB(nc_gpreg) & 0x08)
 				break;
+			/* fall through */
 		case 2:	/* Set HVD unconditionally */
 			np->scsi_mode = SMODE_HVD;
+			/* fall through */
 		case 1:	/* Trust previous settings for HVD */
 			if (np->sv_stest2 & 0x20)
 				np->scsi_mode = SMODE_HVD;
@@ -6714,6 +6717,7 @@ void ncr_int_sir (struct ncb *np)
 			OUTL_DSP (scr_to_cpu(tp->lp[0]->jump_ccb[0]));
 			return;
 		}
+		/* fall through */
 	case SIR_RESEL_BAD_TARGET:	/* Will send a TARGET RESET message */
 	case SIR_RESEL_BAD_LUN:		/* Will send a TARGET RESET message */
 	case SIR_RESEL_BAD_I_T_L_Q:	/* Will send an ABORT TAG message   */
