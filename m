Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729A1ECCEC
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Nov 2019 03:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKBCwW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Nov 2019 22:52:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:38051 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfKBCwW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 Nov 2019 22:52:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 19:52:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="gz'50?scan'50,208,50";a="199982561"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2019 19:52:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQjWT-000CU5-5e; Sat, 02 Nov 2019 10:52:17 +0800
Date:   Sat, 2 Nov 2019 10:52:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        Vasanthalakshmi.Tharmarajan@microchip.com, Viswas.G@microchip.com,
        deepak.ukey@microchip.com, jinpu.wang@profitbricks.com,
        martin.petersen@oracle.com, dpf@google.com, jsperbeck@google.com,
        auradkar@google.com, ianyar@google.com
Subject: Re: [PATCH 12/12] pm80xx : Modified the logic to collect fatal dump.
Message-ID: <201911021012.Yl2xts25%lkp@intel.com>
References: <20191031051241.6762-13-deepak.ukey@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="psujxojtbck3mfus"
Content-Disposition: inline
In-Reply-To: <20191031051241.6762-13-deepak.ukey@microchip.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--psujxojtbck3mfus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Deepak,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[cannot apply to v5.4-rc5 next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Deepak-Ukey/pm80xx-Updates-for-the-driver-version-0-1-39/20191102-082024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: mips-allmodconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/pm8001/pm80xx_hwi.c:42:0:
   drivers/scsi/pm8001/pm80xx_hwi.c: In function 'pm80xx_get_fatal_dump':
>> include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   drivers/scsi/pm8001/pm8001_sas.h:78:4: note: in definition of macro 'PM8001_CHECK_LOGGING'
       CMD;    \
       ^~~
>> drivers/scsi/pm8001/pm80xx_hwi.c:239:4: note: in expansion of macro 'PM8001_IO_DBG'
       PM8001_IO_DBG(pm8001_ha,
       ^~~~~~~~~~~~~
   include/linux/kern_levels.h:14:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_INFO KERN_SOH "6" /* informational */
                      ^~~~~~~~
   include/linux/printk.h:311:9: note: in expansion of macro 'KERN_INFO'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
>> drivers/scsi/pm8001/pm8001_sas.h:72:39: note: in expansion of macro 'pr_info'
    #define pm8001_printk(format, arg...) pr_info("%s:: %s  %d:" \
                                          ^~~~~~~
>> drivers/scsi/pm8001/pm80xx_hwi.c:240:4: note: in expansion of macro 'pm8001_printk'
       pm8001_printk("get_fatal_spcv: return1 0x%lx\n",
       ^~~~~~~~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:240:47: note: format string is defined here
       pm8001_printk("get_fatal_spcv: return1 0x%lx\n",
                                                ~~^
                                                %x
   In file included from drivers/scsi/pm8001/pm80xx_hwi.c:42:0:
>> include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   drivers/scsi/pm8001/pm8001_sas.h:78:4: note: in definition of macro 'PM8001_CHECK_LOGGING'
       CMD;    \
       ^~~
   drivers/scsi/pm8001/pm80xx_hwi.c:261:4: note: in expansion of macro 'PM8001_IO_DBG'
       PM8001_IO_DBG(pm8001_ha,
       ^~~~~~~~~~~~~
   include/linux/kern_levels.h:14:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_INFO KERN_SOH "6" /* informational */
                      ^~~~~~~~
   include/linux/printk.h:311:9: note: in expansion of macro 'KERN_INFO'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
>> drivers/scsi/pm8001/pm8001_sas.h:72:39: note: in expansion of macro 'pr_info'
    #define pm8001_printk(format, arg...) pr_info("%s:: %s  %d:" \
                                          ^~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:262:4: note: in expansion of macro 'pm8001_printk'
       pm8001_printk("get_fatal_spcv: return2 0x%lx\n",
       ^~~~~~~~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:262:47: note: format string is defined here
       pm8001_printk("get_fatal_spcv: return2 0x%lx\n",
                                                ~~^
                                                %x
   In file included from drivers/scsi/pm8001/pm80xx_hwi.c:42:0:
>> include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   drivers/scsi/pm8001/pm8001_sas.h:78:4: note: in definition of macro 'PM8001_CHECK_LOGGING'
       CMD;    \
       ^~~
   drivers/scsi/pm8001/pm80xx_hwi.c:287:3: note: in expansion of macro 'PM8001_IO_DBG'
      PM8001_IO_DBG(pm8001_ha,
      ^~~~~~~~~~~~~
   include/linux/kern_levels.h:14:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_INFO KERN_SOH "6" /* informational */
                      ^~~~~~~~
   include/linux/printk.h:311:9: note: in expansion of macro 'KERN_INFO'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
>> drivers/scsi/pm8001/pm8001_sas.h:72:39: note: in expansion of macro 'pr_info'
    #define pm8001_printk(format, arg...) pr_info("%s:: %s  %d:" \
                                          ^~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:288:3: note: in expansion of macro 'pm8001_printk'
      pm8001_printk("get_fatal_spcv: return3 0x%lx\n",
      ^~~~~~~~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:288:46: note: format string is defined here
      pm8001_printk("get_fatal_spcv: return3 0x%lx\n",
                                               ~~^
                                               %x
   In file included from drivers/scsi/pm8001/pm80xx_hwi.c:42:0:
>> include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   drivers/scsi/pm8001/pm8001_sas.h:78:4: note: in definition of macro 'PM8001_CHECK_LOGGING'
       CMD;    \
       ^~~
   drivers/scsi/pm8001/pm80xx_hwi.c:385:2: note: in expansion of macro 'PM8001_IO_DBG'
     PM8001_IO_DBG(pm8001_ha,
     ^~~~~~~~~~~~~
   include/linux/kern_levels.h:14:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_INFO KERN_SOH "6" /* informational */
                      ^~~~~~~~
   include/linux/printk.h:311:9: note: in expansion of macro 'KERN_INFO'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
>> drivers/scsi/pm8001/pm8001_sas.h:72:39: note: in expansion of macro 'pr_info'
    #define pm8001_printk(format, arg...) pr_info("%s:: %s  %d:" \
                                          ^~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:386:3: note: in expansion of macro 'pm8001_printk'
      pm8001_printk("get_fatal_spcv: return4 0x%lx\n",
      ^~~~~~~~~~~~~
   drivers/scsi/pm8001/pm80xx_hwi.c:386:46: note: format string is defined here
      pm8001_printk("get_fatal_spcv: return4 0x%lx\n",
                                               ~~^
                                               %x

vim +/PM8001_IO_DBG +239 drivers/scsi/pm8001/pm80xx_hwi.c

  > 42	 #include "pm8001_sas.h"
    43	 #include "pm80xx_hwi.h"
    44	 #include "pm8001_chips.h"
    45	 #include "pm8001_ctl.h"
    46	
    47	#define SMP_DIRECT 1
    48	#define SMP_INDIRECT 2
    49	
    50	
    51	int pm80xx_bar4_shift(struct pm8001_hba_info *pm8001_ha, u32 shift_value)
    52	{
    53		u32 reg_val;
    54		unsigned long start;
    55		pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER, shift_value);
    56		/* confirm the setting is written */
    57		start = jiffies + HZ; /* 1 sec */
    58		do {
    59			reg_val = pm8001_cr32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER);
    60		} while ((reg_val != shift_value) && time_before(jiffies, start));
    61		if (reg_val != shift_value) {
    62			PM8001_FAIL_DBG(pm8001_ha,
    63				pm8001_printk("TIMEOUT:MEMBASE_II_SHIFT_REGISTER"
    64				" = 0x%x\n", reg_val));
    65			return -1;
    66		}
    67		return 0;
    68	}
    69	
    70	void pm80xx_pci_mem_copy(struct pm8001_hba_info  *pm8001_ha, u32 soffset,
    71					const void *destination,
    72					u32 dw_count, u32 bus_base_number)
    73	{
    74		u32 index, value, offset;
    75		u32 *destination1;
    76		destination1 = (u32 *)destination;
    77	
    78		for (index = 0; index < dw_count; index += 4, destination1++) {
    79			offset = (soffset + index);
    80			if (offset < (64 * 1024)) {
    81				value = pm8001_cr32(pm8001_ha, bus_base_number, offset);
    82				*destination1 =  cpu_to_le32(value);
    83			}
    84		}
    85		return;
    86	}
    87	
    88	ssize_t pm80xx_get_fatal_dump(struct device *cdev,
    89		struct device_attribute *attr, char *buf)
    90	{
    91		struct Scsi_Host *shost = class_to_shost(cdev);
    92		struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
    93		struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
    94		void __iomem *fatal_table_address = pm8001_ha->fatal_tbl_addr;
    95		u32 accum_len , reg_val, index, *temp;
    96		u32 status = 1;
    97		unsigned long start;
    98		u8 *direct_data;
    99		char *fatal_error_data = buf;
   100		u32 length_to_read;
   101	
   102		pm8001_ha->forensic_info.data_buf.direct_data = buf;
   103		if (pm8001_ha->chip_id == chip_8001) {
   104			pm8001_ha->forensic_info.data_buf.direct_data +=
   105				sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
   106				"Not supported for SPC controller");
   107			return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
   108				(char *)buf;
   109		}
   110		/* initialize variables for very first call from host application */
   111		if (pm8001_ha->forensic_info.data_buf.direct_offset == 0) {
   112			PM8001_IO_DBG(pm8001_ha,
   113			pm8001_printk("forensic_info TYPE_NON_FATAL..............\n"));
   114			direct_data = (u8 *)fatal_error_data;
   115			pm8001_ha->forensic_info.data_type = TYPE_NON_FATAL;
   116			pm8001_ha->forensic_info.data_buf.direct_len = SYSFS_OFFSET;
   117			pm8001_ha->forensic_info.data_buf.direct_offset = 0;
   118			pm8001_ha->forensic_info.data_buf.read_len = 0;
   119			pm8001_ha->forensic_preserved_accumulated_transfer = 0;
   120	
   121			/* Write signature to fatal dump table */
   122			pm8001_mw32(fatal_table_address,
   123					MPI_FATAL_EDUMP_TABLE_SIGNATURE, 0x1234abcd);
   124	
   125			pm8001_ha->forensic_info.data_buf.direct_data = direct_data;
   126			PM8001_IO_DBG(pm8001_ha,
   127				pm8001_printk("ossaHwCB: status1 %d\n", status));
   128			PM8001_IO_DBG(pm8001_ha,
   129				pm8001_printk("ossaHwCB: read_len 0x%x\n",
   130				pm8001_ha->forensic_info.data_buf.read_len));
   131			PM8001_IO_DBG(pm8001_ha,
   132				pm8001_printk("ossaHwCB: direct_len 0x%x\n",
   133				pm8001_ha->forensic_info.data_buf.direct_len));
   134			PM8001_IO_DBG(pm8001_ha,
   135				pm8001_printk("ossaHwCB: direct_offset 0x%x\n",
   136				pm8001_ha->forensic_info.data_buf.direct_offset));
   137		}
   138		if (pm8001_ha->forensic_info.data_buf.direct_offset == 0) {
   139			/* start to get data */
   140			/* Program the MEMBASE II Shifting Register with 0x00.*/
   141			pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER,
   142					pm8001_ha->fatal_forensic_shift_offset);
   143			pm8001_ha->forensic_last_offset = 0;
   144			pm8001_ha->forensic_fatal_step = 0;
   145			pm8001_ha->fatal_bar_loc = 0;
   146		}
   147	
   148		/* Read until accum_len is retrived */
   149		accum_len = pm8001_mr32(fatal_table_address,
   150					MPI_FATAL_EDUMP_TABLE_ACCUM_LEN);
   151		/* Determine length of data between previously stored transfer length
   152		 * and current accumulated transfer length
   153		 */
   154		length_to_read =
   155			accum_len - pm8001_ha->forensic_preserved_accumulated_transfer;
   156		PM8001_IO_DBG(pm8001_ha,
   157			pm8001_printk("get_fatal_spcv: accum_len 0x%x\n", accum_len));
   158		PM8001_IO_DBG(pm8001_ha,
   159			pm8001_printk("get_fatal_spcv: length_to_read 0x%x\n",
   160			length_to_read));
   161		PM8001_IO_DBG(pm8001_ha,
   162			pm8001_printk("get_fatal_spcv: last_offset 0x%x\n",
   163			pm8001_ha->forensic_last_offset));
   164		PM8001_IO_DBG(pm8001_ha,
   165			pm8001_printk("get_fatal_spcv: read_len 0x%x\n",
   166			pm8001_ha->forensic_info.data_buf.read_len));
   167		PM8001_IO_DBG(pm8001_ha,
   168			pm8001_printk("get_fatal_spcv:: direct_len 0x%x\n",
   169			pm8001_ha->forensic_info.data_buf.direct_len));
   170		PM8001_IO_DBG(pm8001_ha,
   171			pm8001_printk("get_fatal_spcv:: direct_offset 0x%x\n",
   172			pm8001_ha->forensic_info.data_buf.direct_offset));
   173	
   174		/* If accumulated length failed to read correctly fail the attempt.*/
   175		if (accum_len == 0xFFFFFFFF) {
   176			PM8001_IO_DBG(pm8001_ha,
   177				pm8001_printk("Possible PCI issue 0x%x not expected\n",
   178				accum_len));
   179			return status;
   180		}
   181		/* If accumulated length is zero fail the attempt */
   182		if (accum_len == 0) {
   183			pm8001_ha->forensic_info.data_buf.direct_data +=
   184				sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
   185				"%08x ", 0xFFFFFFFF);
   186			return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
   187				(char *)buf;
   188		}
   189		/* Accumulated length is good so start capturing the first data */
   190		temp = (u32 *)pm8001_ha->memoryMap.region[FORENSIC_MEM].virt_ptr;
   191		if (pm8001_ha->forensic_fatal_step == 0) {
   192	moreData:
   193			/* If data to read is less than SYSFS_OFFSET then reduce the
   194			 * length of dataLen
   195			 */
   196			if (pm8001_ha->forensic_last_offset + SYSFS_OFFSET
   197					> length_to_read) {
   198				pm8001_ha->forensic_info.data_buf.direct_len =
   199					length_to_read -
   200					pm8001_ha->forensic_last_offset;
   201			} else {
   202				pm8001_ha->forensic_info.data_buf.direct_len =
   203					SYSFS_OFFSET;
   204			}
   205			if (pm8001_ha->forensic_info.data_buf.direct_data) {
   206				/* Data is in bar, copy to host memory */
   207				pm80xx_pci_mem_copy(pm8001_ha,
   208				pm8001_ha->fatal_bar_loc,
   209				pm8001_ha->memoryMap.region[FORENSIC_MEM].virt_ptr,
   210				pm8001_ha->forensic_info.data_buf.direct_len, 1);
   211			}
   212			pm8001_ha->fatal_bar_loc +=
   213				pm8001_ha->forensic_info.data_buf.direct_len;
   214			pm8001_ha->forensic_info.data_buf.direct_offset +=
   215				pm8001_ha->forensic_info.data_buf.direct_len;
   216			pm8001_ha->forensic_last_offset	+=
   217				pm8001_ha->forensic_info.data_buf.direct_len;
   218			pm8001_ha->forensic_info.data_buf.read_len =
   219				pm8001_ha->forensic_info.data_buf.direct_len;
   220	
   221			if (pm8001_ha->forensic_last_offset  >= length_to_read) {
   222				pm8001_ha->forensic_info.data_buf.direct_data +=
   223				sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
   224					"%08x ", 3);
   225				for (index = 0; index <
   226					(pm8001_ha->forensic_info.data_buf.direct_len
   227					 / 4); index++) {
   228					pm8001_ha->forensic_info.data_buf.direct_data +=
   229					sprintf(
   230					pm8001_ha->forensic_info.data_buf.direct_data,
   231					"%08x ", *(temp + index));
   232				}
   233	
   234				pm8001_ha->fatal_bar_loc = 0;
   235				pm8001_ha->forensic_fatal_step = 1;
   236				pm8001_ha->fatal_forensic_shift_offset = 0;
   237				pm8001_ha->forensic_last_offset	= 0;
   238				status = 0;
 > 239				PM8001_IO_DBG(pm8001_ha,
 > 240				pm8001_printk("get_fatal_spcv: return1 0x%lx\n",
   241				((char *)pm8001_ha->forensic_info.data_buf.direct_data
   242				- (char *)buf)));
   243				return (char *)pm8001_ha->
   244					forensic_info.data_buf.direct_data -
   245					(char *)buf;
   246			}
   247			if (pm8001_ha->fatal_bar_loc < (64 * 1024)) {
   248				pm8001_ha->forensic_info.data_buf.direct_data +=
   249					sprintf(pm8001_ha->
   250						forensic_info.data_buf.direct_data,
   251						"%08x ", 2);
   252				for (index = 0; index <
   253					(pm8001_ha->forensic_info.data_buf.direct_len
   254					 / 4); index++) {
   255					pm8001_ha->forensic_info.data_buf.direct_data
   256						+= sprintf(pm8001_ha->
   257						forensic_info.data_buf.direct_data,
   258						"%08x ", *(temp + index));
   259				}
   260				status = 0;
   261				PM8001_IO_DBG(pm8001_ha,
   262				pm8001_printk("get_fatal_spcv: return2 0x%lx\n",
   263				((char *)pm8001_ha->forensic_info.data_buf.direct_data
   264				- (char *)buf)));
   265				return (char *)pm8001_ha->
   266					forensic_info.data_buf.direct_data -
   267					(char *)buf;
   268			}
   269	
   270			/* Increment the MEMBASE II Shifting Register value by 0x100.*/
   271			pm8001_ha->forensic_info.data_buf.direct_data +=
   272				sprintf(pm8001_ha->forensic_info.data_buf.direct_data,
   273					"%08x ", 2);
   274			for (index = 0; index <
   275				(pm8001_ha->forensic_info.data_buf.direct_len
   276				 / 4) ; index++) {
   277				pm8001_ha->forensic_info.data_buf.direct_data +=
   278					sprintf(pm8001_ha->
   279					forensic_info.data_buf.direct_data,
   280					"%08x ", *(temp + index));
   281			}
   282			pm8001_ha->fatal_forensic_shift_offset += 0x100;
   283			pm8001_cw32(pm8001_ha, 0, MEMBASE_II_SHIFT_REGISTER,
   284				pm8001_ha->fatal_forensic_shift_offset);
   285			pm8001_ha->fatal_bar_loc = 0;
   286			status = 0;
   287			PM8001_IO_DBG(pm8001_ha,
   288			pm8001_printk("get_fatal_spcv: return3 0x%lx\n",
   289			((char *)pm8001_ha->forensic_info.data_buf.direct_data
   290			- (char *)buf)));
   291			return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
   292				(char *)buf;
   293		}
   294		if (pm8001_ha->forensic_fatal_step == 1) {
   295			/* store previous accumulated length before triggering next
   296			 * accumulated length update
   297			 */
   298			pm8001_ha->forensic_preserved_accumulated_transfer =
   299				pm8001_mr32(fatal_table_address,
   300				MPI_FATAL_EDUMP_TABLE_ACCUM_LEN);
   301	
   302			/* continue capturing the fatal log until Dump status is 0x3 */
   303			if (pm8001_mr32(fatal_table_address,
   304				MPI_FATAL_EDUMP_TABLE_STATUS) <
   305				MPI_FATAL_EDUMP_TABLE_STAT_NF_SUCCESS_DONE) {
   306	
   307				/* reset fddstat bit by writing to zero*/
   308				pm8001_mw32(fatal_table_address,
   309						MPI_FATAL_EDUMP_TABLE_STATUS, 0x0);
   310	
   311				/* set dump control value to '1' so that new data will
   312				 * be transferred to shared memory
   313				 */
   314				pm8001_mw32(fatal_table_address,
   315					MPI_FATAL_EDUMP_TABLE_HANDSHAKE,
   316					MPI_FATAL_EDUMP_HANDSHAKE_RDY);
   317	
   318				/*Poll FDDHSHK  until clear */
   319				start = jiffies + (2 * HZ); /* 2 sec */
   320	
   321				do {
   322					reg_val = pm8001_mr32(fatal_table_address,
   323						MPI_FATAL_EDUMP_TABLE_HANDSHAKE);
   324				} while ((reg_val) && time_before(jiffies, start));
   325	
   326				if (reg_val != 0) {
   327					PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
   328					"TIMEOUT:MPI_FATAL_EDUMP_TABLE_HDSHAKE 0x%x\n",
   329					reg_val));
   330				       /* Fail the dump if a timeout occurs */
   331					pm8001_ha->forensic_info.data_buf.direct_data +=
   332					sprintf(
   333					pm8001_ha->forensic_info.data_buf.direct_data,
   334					"%08x ", 0xFFFFFFFF);
   335					return((char *)
   336					pm8001_ha->forensic_info.data_buf.direct_data
   337					- (char *)buf);
   338				}
   339				/* Poll status register until set to 2 or
   340				 * 3 for up to 2 seconds
   341				 */
   342				start = jiffies + (2 * HZ); /* 2 sec */
   343	
   344				do {
   345					reg_val = pm8001_mr32(fatal_table_address,
   346						MPI_FATAL_EDUMP_TABLE_STATUS);
   347				} while (((reg_val != 2) || (reg_val != 3)) &&
   348						time_before(jiffies, start));
   349	
   350				if (reg_val < 2) {
   351					PM8001_FAIL_DBG(pm8001_ha, pm8001_printk(
   352					"TIMEOUT:MPI_FATAL_EDUMP_TABLE_STATUS = 0x%x\n",
   353					reg_val));
   354					/* Fail the dump if a timeout occurs */
   355					pm8001_ha->forensic_info.data_buf.direct_data +=
   356					sprintf(
   357					pm8001_ha->forensic_info.data_buf.direct_data,
   358					"%08x ", 0xFFFFFFFF);
   359					pm8001_cw32(pm8001_ha, 0,
   360						MEMBASE_II_SHIFT_REGISTER,
   361						pm8001_ha->fatal_forensic_shift_offset);
   362				}
   363				/* Read the next block of the debug data.*/
   364				length_to_read = pm8001_mr32(fatal_table_address,
   365				MPI_FATAL_EDUMP_TABLE_ACCUM_LEN) -
   366				pm8001_ha->forensic_preserved_accumulated_transfer;
   367				if (length_to_read != 0x0) {
   368					pm8001_ha->forensic_fatal_step = 0;
   369					goto moreData;
   370				} else {
   371					pm8001_ha->forensic_info.data_buf.direct_data +=
   372					sprintf(
   373					pm8001_ha->forensic_info.data_buf.direct_data,
   374					"%08x ", 4);
   375					pm8001_ha->forensic_info.data_buf.read_len
   376									= 0xFFFFFFFF;
   377					pm8001_ha->forensic_info.data_buf.direct_len
   378									=  0;
   379					pm8001_ha->forensic_info.data_buf.direct_offset
   380									= 0;
   381					pm8001_ha->forensic_info.data_buf.read_len = 0;
   382				}
   383			}
   384		}
   385		PM8001_IO_DBG(pm8001_ha,
   386			pm8001_printk("get_fatal_spcv: return4 0x%lx\n",
   387			((char *)pm8001_ha->forensic_info.data_buf.direct_data -
   388			 (char *)buf)));
   389		return (char *)pm8001_ha->forensic_info.data_buf.direct_data -
   390			(char *)buf;
   391	}
   392	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--psujxojtbck3mfus
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
gl7JwFzEqVwHpzD9C/A6wUYa5QMA

--psujxojtbck3mfus--
